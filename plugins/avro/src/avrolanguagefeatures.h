/*
 * Copyright 2021 Abdullah AL Shohag
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

#ifndef AVROLANGUAGEFEATURES_H
#define AVROLANGUAGEFEATURES_H

#include "abstractlanguagefeatures.h"
#include <QObject>

class AvroLanguageFeatures : public QObject, public AbstractLanguageFeatures
{
    Q_OBJECT
public:
    explicit AvroLanguageFeatures(QObject *parent = 0);
    virtual ~AvroLanguageFeatures();

    virtual bool alwaysShowSuggestions() const;
    virtual bool autoCapsAvailable() const;
    virtual bool activateAutoCaps(const QString &preedit) const;
    virtual QString appendixForReplacedPreedit(const QString &preedit) const;
    virtual bool isSeparator(const QString &text) const;
    virtual QString fullStopSequence() const { return QString("."); }
    virtual bool isSymbol(const QString &text) const;
    virtual bool ignoreSimilarity() const;
    virtual bool wordEngineAvailable() const;
};

#endif // AVROLANGUAGEFEATURES_H
