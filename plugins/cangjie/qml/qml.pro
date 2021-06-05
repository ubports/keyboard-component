TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_zh.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/zh-hant/"
lang_zh.files = *.qml *.js *.txt

INSTALLS += lang_zh

# for QtCreator
OTHER_FILES += \
    Keyboard_zh-hant_cangjie.qml \
    Keyboard_zh-hant_cangjie_email.qml \
    Keyboard_zh-hant_cangjie_url.qml \
    Keyboard_zh-hant_cangjie_url_search.qml

