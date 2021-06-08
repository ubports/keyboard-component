/*
 * Copyright 2016 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "quicklanguagefeatures.h"

QuickLanguageFeatures::QuickLanguageFeatures(QObject *parent) :
    QObject(parent)
{
}

QuickLanguageFeatures::~QuickLanguageFeatures()
{
}

bool QuickLanguageFeatures::alwaysShowSuggestions() const
{
    // Chewing characters can only be entered via suggestions, so we ignore
    // hints that would otherwise disable them.
    return true;
}

bool QuickLanguageFeatures::autoCapsAvailable() const
{
    // Automatic switching to capital letters doesn't make sense when 
    // inputting cangjie
    return false;
}

bool QuickLanguageFeatures::activateAutoCaps(const QString &preedit) const
{
    Q_UNUSED(preedit)
    return false;
}

QString QuickLanguageFeatures::appendixForReplacedPreedit(const QString &preedit) const
{
    if (preedit.isEmpty())
        return QString("");

    return QString("");
}

bool QuickLanguageFeatures::isSeparator(const QString &text) const
{
    static const QString separators = QString::fromUtf8("。、!?:…\r\n");

    if (text.isEmpty()) {
        return false;
    }

    if (separators.contains(text.right(1))) {
        return true;
    }

    return false;
}

bool QuickLanguageFeatures::isSymbol(const QString &text) const
{
    static const QString symbols = QString::fromUtf8("*#+=()@~\\€£$¥₹%<>[]`^|_—–•§{}¡¿«»\"“”„&");

    if (text.isEmpty()) {
        return false;
    }

    if (symbols.contains(text.right(1))) {
        return true;
    }

    return false;
}

bool QuickLanguageFeatures::ignoreSimilarity() const
{
    return true;
}

bool QuickLanguageFeatures::wordEngineAvailable() const
{
    return true;
}

QString QuickLanguageFeatures::fullStopSequence() const
{
    return QString("。");
}

bool QuickLanguageFeatures::restorePreedit() const
{
    return false;
}

bool QuickLanguageFeatures::commitOnSpace() const
{
    return true;
}

bool QuickLanguageFeatures::showPrimaryInPreedit() const
{
    return true;
}

