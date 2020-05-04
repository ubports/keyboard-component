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

import "key_constants.js" as UI

FlickActionKey {
    width: panel.keyWidth
    iconNormal:["keyboard-enter", "keyboard-spacebar", "keyboard-caps-disabled", "", "keyboard-caps-locked"]
    iconShifted:["keyboard-enter", "keyboard-spacebar", "keyboard-caps-enabled", "", "keyboard-caps-disabled"]
    iconCapsLock:["keyboard-enter", "keyboard-spacebar", "keyboard-caps-locked", "", "keyboard-caps-disabled"]
    iconAngles:["","","","","180"]
    overridePressArea: true

    property string preedit: maliit_input_method.preedit
    property bool isPreedit: maliit_input_method.preedit.length > 0
    property string default_state:"qertyu"
    property string panelState: panel.activeKeypadState
    property int cursorPosition: maliit_input_method.cursorPosition
    property string lastChar: ""
    property var preeditLeaves: [lastChar]
    state:(panel.autoCapsTriggered)?"caps": kana.state

    Item {
        id: kana

        state: parent.default_state;
        states: [
            State {
                name: "caps"
                PropertyChanges {
                    target: kana;
                    label: "<font color=\"transparent\">Ⓐ</font>";
		    annotation:"ⓐ";
                    state: "caps";
              }
            },
            State {
                name: "qertyu"
                PropertyChanges {
                    target: kana;
                    label: (panel.autoCapsTriggered)?"<font color=\"transparent\">Ⓐ</font>": "Ⓐ";
		    annotation:(panel.autoCapsTriggered)?"ⓐ":"<font color=\"transparent\">ⓐ</font>";
                    state: "qertyu";
                }
            }
        ]
    }

    onReleased: {
        if (isPreedit) {
            if (index != 2 && index !=4) {
                   if (index == 0) event_handler.onKeyReleased("", "commit");
                   if (index == 1) event_handler.onKeyReleased("", "space");
                } else {
                    var pos = cursorPosition
                    var newChar = (lastChar.charCodeAt(0) >= 91 && index == 2) ? lastChar.toUpperCase() : lastChar
                    newChar = (lastChar.charCodeAt(0) < 91 && index == 4) ? lastChar.toLowerCase() : newChar
                    maliit_input_method.preedit = preedit.substr(0, cursorPosition-1) + newChar + preedit.substr(cursorPosition)
                    maliit_input_method.cursorPosition = pos
                }
        }else{
            if (index == 0) {
                    event_handler.onKeyReleased("", "return");
            } else if (index == 1) {
                   event_handler.onKeyReleased("", "space");
            } else if (index == 2) {
                    if (panel.state == "ACCENTS"){
                        kana.state = "caps"
                    }else if (panelState === "NORMAL"){
                        panel.activeKeypadState = "SHIFTED";
                        kana.state = "caps"
                    } else {
                        panel.activeKeypadState = "CAPSLOCK";
                    }
            } else if (index == 4) {
                    if (panel.state == "ACCENTS"){
                        kana.state = "qertyu"
                    }else if (panelState !== "NORMAL"){
                        panel.activeKeypadState = "NORMAL";
                        kana.state = "qertyu"
                    } else {
                        kana.state = "qertyu"
                    }
            }
        }
        if(panel.autoCapsTriggered && index ==4){
                        panel.autoCapsTriggered=false;
                        kana.state = "qertyu"
        }
        if(panel.autoCapsTriggered && index ==2){
                        panel.autoCapsTriggered=false;
                        kana.state = "caps"
        }
    }

    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
            pressEffect.start();
        if (isPreedit) {
            lastChar = preedit.charAt(cursorPosition-1)
        }
    }
}
