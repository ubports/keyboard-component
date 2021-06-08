#include "quickplugin.h"
#include "quicklanguagefeatures.h"

#include <QDebug>

QuickPlugin::QuickPlugin(QObject *parent) :
    AbstractLanguagePlugin(parent)
  , m_quickLanguageFeatures(new QuickLanguageFeatures)
  , m_processingWord(false)
{
    m_quickThread = new QThread();
    m_quickAdapter = new QuickAdapter();
    m_quickAdapter->moveToThread(m_quickThread);

    connect(m_quickAdapter, SIGNAL(newPredictionSuggestions(QString, QStringList)), this, SLOT(finishedProcessing(QString, QStringList)));
    connect(this, SIGNAL(parsePredictionText(QString)), m_quickAdapter, SLOT(parse(QString)));
    connect(this, SIGNAL(candidateSelected(QString)), m_quickAdapter, SLOT(wordCandidateSelected(QString)));
    m_quickThread->start();
}

QuickPlugin::~QuickPlugin()
{
    m_quickAdapter->deleteLater();
    m_quickThread->quit();
    m_quickThread->wait();
}

void QuickPlugin::predict(const QString& surroundingLeft, const QString& preedit)
{
    Q_UNUSED(surroundingLeft);
    m_nextWord = preedit;
    if (!m_processingWord) {
        m_processingWord = true;
        Q_EMIT parsePredictionText(preedit);
    }
}

void QuickPlugin::wordCandidateSelected(QString word)
{
    Q_EMIT candidateSelected(word);
}

AbstractLanguageFeatures* QuickPlugin::languageFeature()
{
    return m_quickLanguageFeatures;
}

void QuickPlugin::finishedProcessing(QString word, QStringList suggestions)
{
    Q_EMIT newPredictionSuggestions(word, suggestions);
    if (word != m_nextWord) {
        Q_EMIT(parsePredictionText(word));
    } else {
        m_processingWord = false;
    }
}
