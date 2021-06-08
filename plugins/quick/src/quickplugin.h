#ifndef QUICKPLUGIN_H
#define QUICKPLUGIN_H

#include <QObject>
#include <QStringList>
#include <QThread>
#include "languageplugininterface.h"
#include "abstractlanguageplugin.h"

#include "quickadapter.h"
#include <iostream>

class QuickLanguageFeatures;

class QuickPlugin : public AbstractLanguagePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.QuickPlugin" FILE "quickplugin.json")
    Q_INTERFACES(LanguagePluginInterface)

public:
    explicit QuickPlugin(QObject *parent = 0);
    virtual ~QuickPlugin();
    
    virtual void predict(const QString& surroundingLeft, const QString& preedit);
    virtual void wordCandidateSelected(QString word);

    virtual AbstractLanguageFeatures* languageFeature();

    //! spell checker
    virtual void spellCheckerSuggest(const QString& word, int limit) { Q_UNUSED(word); Q_UNUSED(limit); }
    virtual void addToSpellCheckerUserWordList(const QString& word) { Q_UNUSED(word); }
    virtual bool setLanguage(const QString& languageId, const QString& pluginPath) { Q_UNUSED(languageId); Q_UNUSED(pluginPath); return false; }

signals:
    void newPredictionSuggestions(QString word, QStringList suggestions);
    void parsePredictionText(QString preedit);
    void candidateSelected(QString word);
    
public slots:
    void finishedProcessing(QString word, QStringList suggestions);
    
private:
    QThread *m_quickThread;
    QuickAdapter *m_quickAdapter;
    QuickLanguageFeatures* m_quickLanguageFeatures;
    QString m_nextWord;
    bool m_processingWord;
};

#endif // QUICKPLUGIN_H
