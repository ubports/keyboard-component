/*
 * Copyright 2013 Canonical Ltd.
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

import QtQuick 2.4

import Ubuntu.Components 1.3

import "key_constants.js" as UI

FlickCharKey {
    property string shifted:"?123"
    fontSize: (fullScreenItem.landscape ? (height / 2) : (height / 2.8)) 
                           * (4 / (label.length >= 2 ? (label.length <= 6 ? label.length + 2.5 : 8) : 4));
    property int visHeight: panel.keyHeight
    property int padding: UI.actionKeyPadding
    width: panel.keyWidth + units.gu( padding )
    normalColor: fullScreenItem.theme.actionKeyColor
    pressedColor: fullScreenItem.theme.actionKeyPressedColor
    borderColor: fullScreenItem.theme.actionKeyBorderColor
}
