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
    sardinianplugin.h

TARGET          = $$qtLibraryTarget(caplugin)

EXAMPLE_FILES = sardinianplugin.json

# generate database for presage:
PLUGIN_INSTALL_PATH = $${UBUNTU_KEYBOARD_LIB_DIR}/sc/

lang_db_sc.commands += \
  rm -f $$PWD/database_sc.db && \
  text2ngram -n 1 -l -f sqlite -o $$PWD/database_sc.db $$PWD/corpus.txt && \
  text2ngram -n 2 -l -f sqlite -o $$PWD/database_sc.db $$PWD/corpus.txt && \
  text2ngram -n 3 -l -f sqlite -o $$PWD/database_sc.db $$PWD/corpus.txt
lang_db_sc.files += $$PWD/database_sc.db

lang_db_sc_install.files += $$PWD/database_sc.db
lang_db_sc_install.path = $$PLUGIN_INSTALL_PATH

QMAKE_EXTRA_TARGETS += lang_db_sc lang_db_sc_install

overrides.files += $$PWD/overrides.csv
overrides.path += $$PLUGIN_INSTALL_PATH

target.path = $$PLUGIN_INSTALL_PATH
INSTALLS += target lang_db_sc_install overrides

OTHER_FILES += \
    sardinianplugin.json \
    corpus.txt

LIBS += $${TOP_BUILDDIR}/plugins/plugins/libwesternsupport.a -lpresage -lhunspell

INCLUDEPATH += $$PWD/../../westernsupport
DEPENDPATH += $$PWD/../../westernsupport
