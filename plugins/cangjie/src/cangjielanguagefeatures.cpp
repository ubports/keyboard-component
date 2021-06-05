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

#include "cangjielanguagefeatures.h"

CangjieLanguageFeatures::CangjieLanguageFeatures(QObject *parent) :
    QObject(parent)
{
}

CangjieLanguageFeatures::~CangjieLanguageFeatures()
{
}

bool CangjieLanguageFeatures::alwaysShowSuggestions() const
{
    // Chewing characters can only be entered via suggestions, so we ignore
    // hints that would otherwise disable them.
    return true;
}

bool CangjieLanguageFeatures::autoCapsAvailable() const
{
    // Automatic switching to capital letters doesn't make sense when 
    // inputting cangjie
    return false;
}

bool CangjieLanguageFeatures::activateAutoCaps(const QString &preedit) const
{
    Q_UNUSED(preedit)
    return false;
}

QString CangjieLanguageFeatures::appendixForReplacedPreedit(const QString &preedit) const
{
    if (preedit.isEmpty())
        return QString("");

    return QString(" ");
}

bool CangjieLanguageFeatures::isSeparator(const QString &text) const
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

bool CangjieLanguageFeatures::isSymbol(const QString &text) const
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

bool CangjieLanguageFeatures::ignoreSimilarity() const
{
    return true;
}

bool CangjieLanguageFeatures::wordEngineAvailable() const
{
    return true;
}

QString CangjieLanguageFeatures::fullStopSequence() const
{
    return QString("。");
}

bool CangjieLanguageFeatures::restorePreedit() const
{
    return false;
}

bool CangjieLanguageFeatures::commitOnSpace() const
{
    return false;
}

bool CangjieLanguageFeatures::showPrimaryInPreedit() const
{
    return true;
}

