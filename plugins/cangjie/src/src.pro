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
                  cangjieadapter.h \
                  cangjieplugin.h \
                  cangjielanguagefeatures.h \
                  $${TOP_SRCDIR}/src/lib/logic/abstractlanguageplugin.h

SOURCES         = \
                  cangjieadapter.cpp \
                  cangjieplugin.cpp \
                  cangjielanguagefeatures.cpp \
                  $${TOP_SRCDIR}/src/lib/logic/abstractlanguageplugin.cpp

TARGET          = $$qtLibraryTarget(zh-hantplugin)

EXAMPLE_FILES = cangjieplugin.json

# install
target.path = $${UBUNTU_KEYBOARD_LIB_DIR}/zh-hant/
INSTALLS += target

OTHER_FILES += \
    cangjieplugin.json

CONFIG += link_pkgconfig
PKGCONFIG += glib-2.0
