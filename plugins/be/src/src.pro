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
    belarusianplugin.h

TARGET          = $$qtLibraryTarget(beplugin)

EXAMPLE_FILES = belarusianplugin.json

# generate database for presage:
PLUGIN_INSTALL_PATH = $${UBUNTU_KEYBOARD_LIB_DIR}/be/

lang_db_be.commands += \
  rm -f $$PWD/database_be.db && \
  text2ngram -n 1 -l -f sqlite -o $$PWD/database_be.db $$PWD/free_ebook.txt && \
  text2ngram -n 2 -l -f sqlite -o $$PWD/database_be.db $$PWD/free_ebook.txt && \
  text2ngram -n 3 -l -f sqlite -o $$PWD/database_be.db $$PWD/free_ebook.txt
lang_db_be.files += $$PWD/database_be.db

lang_db_be_install.files += $$PWD/database_be.db
lang_db_be_install.path = $$PLUGIN_INSTALL_PATH

QMAKE_EXTRA_TARGETS += lang_db_be lang_db_be_install

target.path = $$PLUGIN_INSTALL_PATH
INSTALLS += target lang_db_be_install

OTHER_FILES += \
    belarusianplugin.json \
    free_ebook.txt

PKGCONFIG += hunspell
LIBS += $${TOP_BUILDDIR}/plugins/plugins/libwesternsupport.a -lpresage

INCLUDEPATH += $$PWD/../../westernsupport
DEPENDPATH += $$PWD/../../westernsupport
