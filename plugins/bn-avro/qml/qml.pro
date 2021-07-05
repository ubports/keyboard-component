TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_bn-avro.path = "$$UBUNTU_KEYBOARD_LIB_DIR/bn-avro/"
lang_bn-avro.files = *.qml *.js

INSTALLS += lang_bn-avro

# for QtCreator
OTHER_FILES += \
    Keyboard_bn-avro.qml \
    Keyboard_bn-avro_email.qml \
    Keyboard_bn-avro_url.qml \
    Keyboard_bn-avro_url_search.qml
