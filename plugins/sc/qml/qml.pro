TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_sc.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/sc/"
lang_sc.files = *.qml *.js

INSTALLS += lang_sc

# for QtCreator
OTHER_FILES += \
    Keyboard_sc.qml \
    Keyboard_sc_email.qml \
    Keyboard_sc_url.qml \
    Keyboard_sc_url_search.qml

