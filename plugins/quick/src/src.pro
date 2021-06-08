TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TEMPLATE        = lib
CONFIG         += plugin
QT             += widgets
INCLUDEPATH    += \
    $${TOP_SRCDIR}/src/ \
    $${TOP_SRCDIR}/src/lib/logic

HEADERS         = \
                  quickadapter.h \
                  quickplugin.h \
                  quicklanguagefeatures.h \
                  $${TOP_SRCDIR}/src/lib/logic/abstractlanguageplugin.h

SOURCES         = \
                  quickadapter.cpp \
                  quickplugin.cpp \
                  quicklanguagefeatures.cpp \
                  $${TOP_SRCDIR}/src/lib/logic/abstractlanguageplugin.cpp

TARGET          = $$qtLibraryTarget(zh-hant-quickplugin)

EXAMPLE_FILES = quickplugin.json

# install
target.path = $${UBUNTU_KEYBOARD_LIB_DIR}/zh-hant-quick/
INSTALLS += target

OTHER_FILES += \
    quickplugin.json

CONFIG += link_pkgconfig
PKGCONFIG += glib-2.0
