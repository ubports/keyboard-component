TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_bn.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/bn/"
lang_bn.files = *.qml *.js

INSTALLS += lang_bn

# for QtCreator
OTHER_FILES += \
    Keyboard_bn.qml \
    Keyboard_bn_email.qml \
    Keyboard_bn_url.qml \
    Keyboard_bn_url_search.qml

