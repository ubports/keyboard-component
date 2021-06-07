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

#include "cangjieadapter.h"

#include <iostream>

#include <iconv.h>
#include <string>
#include <string.h>

#include <QFile>
#include <QTextStream>
#include <QChar>
#include <QCoreApplication>

#define CANGJIE_MAX_LEN 32

CangjieAdapter::CangjieAdapter(QObject *parent) :
    QObject(parent),
    m_processingWords(false)
{
    prepareDb();
}

CangjieAdapter::~CangjieAdapter()
{
    //chewing_delete(m_chewingContext);
}

void CangjieAdapter::prepareDb()
{
    QFile inputFile(QString(UBUNTU_KEYBOARD_DATA_DIR) + QString("/lib/zh-hant-cangjie/cangjie3.txt"));

    if (inputFile.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream in(&inputFile);

        while (!in.atEnd())
        {
            QString line = in.readLine();

            QString firstChar = line.left(1);

            if (!m_wordDb.contains(firstChar)) {
                m_wordDb[firstChar] = QStringList();
            }

            m_wordDb[firstChar] << line;
        }
    }
}

void CangjieAdapter::parse(const QString& string)
{
    QString characters = "abcdefghijklmnopqrstuvwxyz";

    m_candidates.clear();

    QString firstChar = string.left(1);
    
    if (firstChar.isLower()) {
        firstChar = firstChar.toLower();

        if (characters.contains(firstChar) && m_wordDb.contains(firstChar)) {
            QStringList list = m_wordDb[firstChar];

            for (int i = 0; i < list.size(); i++) {
                QString line = list[i];
                QStringList values = line.split(QLatin1Char(' '));

                if (values.size() > 1) {
                    if (values[0].startsWith(string.trimmed())) {
                        m_candidates << values[1];
                    }
                }

                if (m_candidates.size() > 40)
                    break;
            }
        }
    }

    if (string.endsWith(" ") && m_candidates.size() > 0) {
        QString selected = m_candidates[0];
        m_candidates.clear();
        m_candidates << selected;
    }

    Q_EMIT newPredictionSuggestions(string, m_candidates);
}

void CangjieAdapter::clearCangjiePreedit()
{
    // Not Using
}

void CangjieAdapter::wordCandidateSelected(const QString& word)
{
    Q_UNUSED(word)
}

void CangjieAdapter::reset()
{
    clearCangjiePreedit();
}

