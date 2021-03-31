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
    charlabel: (state == "marks") ? ["", "", "a!", "", ""] : (panel.state == "CHARACTERS") ? ["", "", "ä‽", "", "īø"] : ["", "", "", "", "a!"]
    leaves: (state == "marks") ? ["", "", "a!", "", ""] : (panel.state == "CHARACTERS") ? ["", "", "ä‽", "", "īø"] : ["", "", "", "", "a!"]
    iconNormal: (state == "marks") ? ["settings", "", "", "", ""] : panel.state == "CHARACTERS" ? ["language-chooser", "", "", "", ""] : ["navigation-menu", "", "", "", ""]
    iconNormalSource: ["", "", "", "../images/happy.svg", ""]
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
            if(state == "marks") {
                Qt.openUrlExternally("settings:///system/language");
                maliit_input_method.hide();
            } else if (maliit_input_method.previousLanguage && maliit_input_method.previousLanguage != maliit_input_method.activeLanguage && panel.state == "CHARACTERS") {
                if(maliit_input_method.previousLanguage == "emoji")
                    canvas.languageMenuShown = true;
                else
                    maliit_input_method.activeLanguage = maliit_input_method.previousLanguage;
            } else {
                canvas.languageMenuShown = true;
            }
        } else if (index == 2) {
	    panel.state = (state == "marks") ? "CHARACTERS" : "ACCENTS";
            state = (state == "marks") ? "signs" : "marks";
        } else if (index == 3) {
            //panel.state = (panel.state != "EMOJI") ? "EMOJI" : "CHARACTERS";
            maliit_input_method.activeLanguage = "emoji";
        } else if (index == 4) {
	    if(panel.state == "ACCENTS" && state =="signs") panel.state = "CHARACTERS";
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
