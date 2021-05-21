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
    ukrainianplugin.h

TARGET          = $$qtLibraryTarget(ukplugin)

EXAMPLE_FILES = ukrainianplugin.json

# generate database for presage:
PLUGIN_INSTALL_PATH = $${UBUNTU_KEYBOARD_LIB_DIR}/uk/

lang_db_uk.commands += \
  rm -f $$PWD/database_uk.db && \
  text2ngram -n 1 -l -f sqlite -o $$PWD/database_uk.db $$PWD/free_ebook.txt && \
  text2ngram -n 2 -l -f sqlite -o $$PWD/database_uk.db $$PWD/free_ebook.txt && \
  text2ngram -n 3 -l -f sqlite -o $$PWD/database_uk.db $$PWD/free_ebook.txt
lang_db_uk.files += $$PWD/database_uk.db

lang_db_uk_install.files += $$PWD/database_uk.db
lang_db_uk_install.path = $$PLUGIN_INSTALL_PATH

QMAKE_EXTRA_TARGETS += lang_db_uk lang_db_uk_install

target.path = $$PLUGIN_INSTALL_PATH
INSTALLS += target lang_db_uk_install

OTHER_FILES += \
    ukrainianplugin.json \
    free_ebook.txt

PKGCONFIG += hunspell
LIBS += $${TOP_BUILDDIR}/plugins/plugins/libwesternsupport.a -lpresage

INCLUDEPATH += $$PWD/../../westernsupport
DEPENDPATH += $$PWD/../../westernsupport
