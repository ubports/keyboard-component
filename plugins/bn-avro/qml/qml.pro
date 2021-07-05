TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_bn-avro.path = "$$UBUNTU_KEYBOARD_LIB_DIR/bn-avro/"
lang_bn-avro.files = *.qml *.js

lang_bn-avro_keys.path = "$$UBUNTU_KEYBOARD_LIB_DIR/bn-avro/keys"
lang_bn-avro_keys.files = keys/*.qml keys/*.js

INSTALLS += lang_bn-avro lang_bn-avro_keys

# for QtCreator
OTHER_FILES += \
    Keyboard_bn-avro.qml \
    Keyboard_bn-avro_email.qml \
    Keyboard_bn-avro_url.qml \
    Keyboard_bn-avro_url_search.qml
