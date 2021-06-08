TOP_BUILDDIR = $$OUT_PWD/../../..
TOP_SRCDIR = $$PWD/../../..

include($${TOP_SRCDIR}/config.pri)

TARGET = dummy
TEMPLATE = lib

lang_zh_quick.path = "$${UBUNTU_KEYBOARD_LIB_DIR}/zh-hant-quick/"
lang_zh_quick.files = *.qml *.js *.txt

INSTALLS += lang_zh_quick

# for QtCreator
OTHER_FILES += \
    Keyboard_zh-hant-quick.qml \
    Keyboard_zh-hant-quick_email.qml \
    Keyboard_zh-hant-quick_url_search.qml \
    Keyboard_zh-hant-quick_url.qml

