TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TEMPLATE        = lib
CONFIG         += plugin
QT             += widgets
INCLUDEPATH    += \
    $${TOP_SRCDIR}/src/ \
    $${TOP_SRCDIR}/src/lib/ \
    $${TOP_SRCDIR}/src/lib/logic/
    $${TOP_SRCDIR}/plugins/westernsupport

HEADERS         = \
    arabicplugin.h

TARGET          = $$qtLibraryTarget(arabicplugin)

EXAMPLE_FILES = arabicplugin.json

# generate database for presage:
PLUGIN_INSTALL_PATH = $${UBUNTU_KEYBOARD_LIB_DIR}/ar/

lang_db_ar.path = $$PLUGIN_INSTALL_PATH
lang_db_ar.commands += \
  rm -f $$PWD/database_ar.db && \
  text2ngram -n 1 -l -f sqlite -o $$PWD/database_ar.db $$PWD/free_ebook.txt && \
  text2ngram -n 2 -l -f sqlite -o $$PWD/database_ar.db $$PWD/free_ebook.txt && \
  text2ngram -n 3 -l -f sqlite -o $$PWD/database_ar.db $$PWD/free_ebook.txt

lang_db_ar.files += $$PWD/database_ar.db
QMAKE_EXTRA_TARGETS += lang_db_ar

target.path = $$PLUGIN_INSTALL_PATH
INSTALLS += target lang_db_ar

OTHER_FILES += \
    arabicplugin.json \
    free_ebook.txt

LIBS += $${TOP_SRCDIR}/plugins/plugins/libwesternsupport.a -lpresage

INCLUDEPATH += $$PWD/../../westernsupport
DEPENDPATH += $$PWD/../../westernsupport
