#include "cangjieplugin.h"
#include "cangjielanguagefeatures.h"

#include <QDebug>

CangjiePlugin::CangjiePlugin(QObject *parent) :
    AbstractLanguagePlugin(parent)
  , m_cangjieLanguageFeatures(new CangjieLanguageFeatures)
  , m_processingWord(false)
{
    m_cangjieThread = new QThread();
    m_cangjieAdapter = new CangjieAdapter();
    m_cangjieAdapter->moveToThread(m_cangjieThread);

    connect(m_cangjieAdapter, SIGNAL(newPredictionSuggestions(QString, QStringList)), this, SLOT(finishedProcessing(QString, QStringList)));
    connect(this, SIGNAL(parsePredictionText(QString)), m_cangjieAdapter, SLOT(parse(QString)));
    connect(this, SIGNAL(candidateSelected(QString)), m_cangjieAdapter, SLOT(wordCandidateSelected(QString)));
    m_cangjieThread->start();
}

CangjiePlugin::~CangjiePlugin()
{
    m_cangjieAdapter->deleteLater();
    m_cangjieThread->quit();
    m_cangjieThread->wait();
}

void CangjiePlugin::predict(const QString& surroundingLeft, const QString& preedit)
{
    Q_UNUSED(surroundingLeft);
    m_nextWord = preedit;
    if (!m_processingWord) {
        m_processingWord = true;
        Q_EMIT parsePredictionText(preedit);
    }
}

void CangjiePlugin::wordCandidateSelected(QString word)
{
    Q_EMIT candidateSelected(word);
}

AbstractLanguageFeatures* CangjiePlugin::languageFeature()
{
    return m_cangjieLanguageFeatures;
}

void CangjiePlugin::finishedProcessing(QString word, QStringList suggestions)
{
    Q_EMIT newPredictionSuggestions(word, suggestions);
    if (word != m_nextWord) {
        Q_EMIT(parsePredictionText(word));
    } else {
        m_processingWord = false;
    }
}
