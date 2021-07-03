TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_avro.path = "$$UBUNTU_KEYBOARD_LIB_DIR/avro/"
lang_avro.files = *.qml *.js

INSTALLS += lang_avro

# for QtCreator
OTHER_FILES += \
    Keyboard_avro.qml \
    Keyboard_avro_email.qml \
    Keyboard_avro_url.qml \
    Keyboard_avro_url_search.qml
