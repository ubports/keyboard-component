/*
 * Copyright 2015 Canonical Ltd.
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
import QtMultimedia 5.0
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "modifier.js" as Modifier
import "key_constants.js" as UI
FlickCharKey {
    label: isPreedit ? "␣ ␣ ␣" : "&lt; - >"
	    leaves: isPreedit ? ["<font size=\"7\">A⇔a</font>", "␣", "␣", "␣"] : [",", "<", "-", ">", "+"];
    annotation: isPreedit ? "A⇔a" : ",+"
    fontSize: isPreedit ? units.gu( UI.fontSize ) * 0.8 : units.gu( UI.fontSize )


    property string layoutState: "kana"
    property string preedit: maliit_input_method.preedit
    property int cursorPosition: maliit_input_method.cursorPosition
    property bool isPreedit: preedit != ""
    property string lastChar: ""
    property var preeditLeaves: Modifier.map[lastChar] ? Modifier.map[lastChar] : [lastChar]
    overridePressArea: (isPreedit)?true:false

    onReleased: {
        if (isPreedit) {
                if (index != 0) {
                   if (index == 1) event_handler.onKeyReleased("", "backspace");
	           if (index == 2) fullScreenItem.cursorSwipe=true	
                   if (index == 3) event_handler.onKeyReleased("", "space");
		   if (index == 4) event_handler.onKeyReleased("", "return"); 
                } else {
                    var pos = cursorPosition
                    var newChar = lastChar.charCodeAt(0) < 91 ? lastChar.toLowerCase() : lastChar.toUpperCase()
                    maliit_input_method.preedit = preedit.substr(0, cursorPosition-1) + newChar + preedit.substr(cursorPosition)
                    maliit_input_method.cursorPosition = pos
                }
        } else {
	    if (index == 0) {
                event_handler.onKeyReleased("", "space");
            }
        }
    }

    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
             pressEffect.start();

        if (isPreedit) {
            lastChar = preedit.charAt(cursorPosition-1)
            if (!Modifier.map[lastChar] && Modifier.normalize[lastChar]) {
                lastChar = Modifier.normalize[lastChar]
            }
        }
    }
}
