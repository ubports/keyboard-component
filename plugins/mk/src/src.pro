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
    macedonianplugin.h

TARGET          = $$qtLibraryTarget(mkplugin)

EXAMPLE_FILES = macedonianplugin.json

# generate database for presage:
PLUGIN_INSTALL_PATH = $${UBUNTU_KEYBOARD_LIB_DIR}/mk/

lang_db_mk.commands += \
  rm -f $$PWD/database_mk.db && \
  text2ngram -n 1 -l -f sqlite -o $$PWD/database_mk.db $$PWD/free_ebook.txt && \
  text2ngram -n 2 -l -f sqlite -o $$PWD/database_mk.db $$PWD/free_ebook.txt && \
  text2ngram -n 3 -l -f sqlite -o $$PWD/database_mk.db $$PWD/free_ebook.txt
lang_db_mk.files += $$PWD/database_mk.db

lang_db_mk_install.files += $$PWD/database_mk.db
lang_db_mk_install.path = $$PLUGIN_INSTALL_PATH

QMAKE_EXTRA_TARGETS += lang_db_sr lang_db_mk_install

target.path = $$PLUGIN_INSTALL_PATH
INSTALLS += target lang_db_sr_install

OTHER_FILES += \
    macedonianplugin.json \
    free_ebook.txt

LIBS += $${TOP_BUILDDIR}/plugins/plugins/libwesternsupport.a -lpresage -lhunspell

INCLUDEPATH += $$PWD/../../westernsupport
DEPENDPATH += $$PWD/../../westernsupport
