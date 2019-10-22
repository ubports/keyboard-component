#ifndef FRENCHBEPPLUGIN_H
#define FRENCHBEPPLUGIN_H

#include <QObject>
#include "languageplugininterface.h"
#include "westernlanguagesplugin.h"

//#include <presage.h>

class FrenchbepPlugin : public WesternLanguagesPlugin
{
    Q_OBJECT
    Q_INTERFACES(LanguagePluginInterface)
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.FrenchBepPlugin" FILE "frenchbepplugin.json")

public:
    explicit FrenchPlugin(QObject* parent = 0)
        : WesternLanguagesPlugin(parent)
    {
    }

    virtual ~FrenchBepPlugin()
    {
    }
};

#endif // FRENCHBEPPLUGIN_H
