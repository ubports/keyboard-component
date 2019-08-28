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
    englishdvorakplugin.h

TARGET          = $$qtLibraryTarget(en@dvplugin)

EXAMPLE_FILES = englishdvorakplugin.json

# generate database for presage:
PLUGIN_INSTALL_PATH = $${UBUNTU_KEYBOARD_LIB_DIR}/en@dv/

lang_db_en@dv.commands += \
  rm -f $$PWD/database_en@dv.db && \
  text2ngram -n 1 -l -f sqlite -o $$PWD/database_en@dv.db $$PWD/the_picture_of_dorian_gray.txt && \
  text2ngram -n 2 -l -f sqlite -o $$PWD/database_en@dv.db $$PWD/the_picture_of_dorian_gray.txt && \
  text2ngram -n 3 -l -f sqlite -o $$PWD/database_en@dv.db $$PWD/the_picture_of_dorian_gray.txt
lang_db_en@dv.files += $$PWD/database_en@dv.db

lang_db_en@dv_install.files += $$PWD/database_en@dv.db
lang_db_en@dv_install.path = $$PLUGIN_INSTALL_PATH

QMAKE_EXTRA_TARGETS += lang_db_en@dv lang_db_en@dv_install

overrides.files += $$PWD/overrides.csv
overrides.path += $$PLUGIN_INSTALL_PATH

target.path = $$PLUGIN_INSTALL_PATH
INSTALLS += target lang_db_en@dv_install overrides

OTHER_FILES += \
    englishdvorakplugin.json \
    the_picture_of_dorian_gray.txt

LIBS += $${TOP_BUILDDIR}/plugins/plugins/libwesternsupport.a -lpresage -lhunspell

INCLUDEPATH += $$PWD/../../westernsupport
DEPENDPATH += $$PWD/../../westernsupport
