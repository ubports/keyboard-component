TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_bn.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/bn/"
lang_bn.files = *.qml *.js

lang_bn_keys.path = "$$UBUNTU_KEYBOARD_LIB_DIR/bn/keys"
lang_bn_keys.files = keys/*.qml

INSTALLS += lang_bn lang_bn_keys

# for QtCreator
OTHER_FILES += \
    Keyboard_bn.qml \
    Keyboard_bn_email.qml \
    Keyboard_bn_url.qml \
    Keyboard_bn_url_search.qml \
    Keyboard_symbols.qml

