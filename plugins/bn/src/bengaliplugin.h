 #ifndef BENGALIPLUGIN_H
#define BENGALIPLUGIN_H

#include <QObject>
#include "languageplugininterface.h"
#include "westernlanguagesplugin.h"

class BengaliPlugin : public WesternLanguagesPlugin
{
    Q_OBJECT
    Q_INTERFACES(LanguagePluginInterface)
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.Examples.BengaliPlugin" FILE "bengaliplugin.json")

public:
    explicit BengaliPlugin(QObject* parent = 0)
        : WesternLanguagesPlugin(parent)
    {
    }

    virtual ~BengaliPlugin()
    {
    }
};

#endif // BENGALIPLUGIN_H
