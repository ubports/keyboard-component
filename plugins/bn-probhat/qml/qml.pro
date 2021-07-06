TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_bn-probhat.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/bn-probhat/"
lang_bn-probhat.files = *.qml *.js

INSTALLS += lang_bn-probhat

# for QtCreator
OTHER_FILES += \
    Keyboard_bn-probhat.qml \
    Keyboard_bn-probhat_email.qml \
    Keyboard_bn-probhat_url.qml \
    Keyboard_bn-probhat_url_search.qml

