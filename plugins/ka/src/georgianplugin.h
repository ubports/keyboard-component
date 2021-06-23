#ifndef GEORGIANPLUGIN_H
#define GEORGIANPLUGIN_H

#include <QObject>
#include "languageplugininterface.h"
#include "westernlanguagesplugin.h"

class GeorgianPlugin : public WesternLanguagesPlugin
{
    Q_OBJECT
    Q_INTERFACES(LanguagePluginInterface)
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.GeorgianPlugin" FILE "georgianplugin.json")

public:
    explicit GeorgianPlugin(QObject* parent = 0)
        : WesternLanguagesPlugin(parent)
    {
    }

    virtual ~GeorgianPlugin()
    {
    }
};

#endif // GEORGIANPLUGIN_H
