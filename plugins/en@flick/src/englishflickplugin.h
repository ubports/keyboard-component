#ifndef ENGLISHFLICKPLUGIN_H
#define ENGLISHFLICKPLUGIN_H

#include <QObject>
#include "languageplugininterface.h"
#include "westernlanguagesplugin.h"

//#include <presage.h>

class EnglishFlickPlugin : public WesternLanguagesPlugin
{
    Q_OBJECT
    Q_INTERFACES(LanguagePluginInterface)
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.EnglishFlickPlugin" FILE "englishflickplugin.json")

public:
    explicit EnglishFlickPlugin(QObject* parent = 0)
        : WesternLanguagesPlugin(parent)
    {
    }

    virtual ~EnglishFlickPlugin()
    {
    }
};

#endif // ENGLISHFLICKPLUGIN_H
