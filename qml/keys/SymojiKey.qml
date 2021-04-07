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

import "key_constants.js" as UI

FlickActionKey {
    id: symojiKey
    property bool standard: (maliit_input_method.previousLanguage && panel.state == "CHARACTERS" && state == "signs") ? true : false
    property bool stdsingle: (!maliit_input_method.previousLanguage && panel.state == "CHARACTERS" && state == "signs") ? true : false
    charlabel: (state == "marks") ? ["", "", "a!", "", ""] : (panel.state == "CHARACTERS") ? ["", "", "ä‽", "", "īø"] : ["", "", "", "", "a!"]
    leaves: charlabel
    iconNormal: stdsingle? ["", "", "", "settings", ""]: ["language-chooser", "", "", "navigation-menu", ""]
    iconNormalSource: standard ? ["", "", "", "../images/happy.svg", ""] : maliit_input_method.previousLanguage ?["", "", "", "", ""]:["../images/happy.svg", "", "", "", ""]
    iconAngles:["","","","","180"]
    iconDisabled: ["", "", "keyboard-caps-locked", "", "keyboard-caps-locked"]
    shiftedlabel: charlabel
    shiftedleaves: leaves
    width: panel.keyWidth;
    action: "symbols";

    overridePressArea: true;
    property string default_state:"signs"
    state: diacritics.state

    Item {
        id: diacritics

        state: parent.default_state;
        states: [
            State {
                name: "marks"
                PropertyChanges {
                    target: diacritics;
                    state: "marks";
              }
            },
            State {
                name: "signs"
                PropertyChanges {
                    target: diacritics;
                    state: "signs";
                }
            }
        ]
    }

    onReleased: {
        if (index == 0) {
            if (maliit_input_method.previousLanguage && maliit_input_method.previousLanguage != maliit_input_method.activeLanguage && panel.state == "CHARACTERS") {
                    maliit_input_method.activeLanguage = maliit_input_method.previousLanguage;
            } else {
		panel.state = "EMOJI";
            }
        } else if (index == 2) {
	    panel.state = (state == "marks") ? "CHARACTERS" : "accents";
            state = (state == "marks") ? "signs" : "marks";
        } else if (index == 3) {
            if(standard)
                 panel.state = "EMOJI";
            else if(panel.state == "CHARACTERS" && state == "signs"){
                 Qt.openUrlExternally("settings:///system/language")
                 maliit_input_method.hide();
            }else {
                 canvas.languageMenuShown = true;
	    }
        } else if (index == 4) {
	    if(panel.state == "accents" && state =="signs") panel.state = "CHARACTERS";
            else state="marks";
        }
    }
    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
            pressEffect.start();

    }
}
