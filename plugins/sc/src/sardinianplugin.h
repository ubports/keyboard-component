#ifndef SARDINIANPLUGIN_H
#define SARDINIANPLUGIN_H

#include <QObject>
#include "languageplugininterface.h"
#include "westernlanguagesplugin.h"

class CatalanPlugin : public WesternLanguagesPlugin
{
    Q_OBJECT
    Q_INTERFACES(LanguagePluginInterface)
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.SardinianPlugin" FILE "sardinianplugin.json")

public:
    explicit SardinianPlugin(QObject* parent = 0)
        : WesternLanguagesPlugin(parent)
    {
    }

    virtual ~SardinianPlugin()
    {
    }
};

#endif // SARDINIANPLUGIN_H
