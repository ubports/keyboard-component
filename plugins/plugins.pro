CONFIG += ordered
TEMPLATE = subdirs
SUBDIRS = \
    westernsupport \
    ar \
    az \
    be \
    bg \
    bs \
    ca \
    cs \
    da \
    de \
    el \
    en \
    en@dv \
    eo \
    es \
    fa \
    fi \
    fr \
    fr-ch \
    gd \
    he \
    hr \
    hu \
    is \
    it \
    ja \
    lt \
    lv \
    mk \
    ko \
    nb \
    nl \
    pl \
    pt \
    ro \
    ru \
    th \
    tr \
    sl \
    sr \
    sv \
    uk \
    pinyin \
    chewing \

QMAKE_EXTRA_TARGETS += check
check.target = check
check.CONFIG = recursive
