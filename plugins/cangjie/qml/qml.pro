TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_zh_cangjie.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/zh-hant-cangjie/"
lang_zh_cangjie.files = *.qml *.js *.txt

INSTALLS += lang_zh_cangjie

# for QtCreator
OTHER_FILES += \
    Keyboard_zh-hant-cangjie.qml \
    Keyboard_zh-hant-cangjie_email.qml \
    Keyboard_zh-hant-cangjie_url_search.qml \
    Keyboard_zh-hant-cangjie_url.qml

