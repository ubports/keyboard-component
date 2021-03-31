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
    charlabel: (panel.state == "CHARACTERS") ? ["", "", "ä‽", "", "īø"] : (state == "marks") ? ["", "", "a!", "", ""] : ["", "", "", "", "a!"]
    leaves: (panel.state == "CHARACTERS") ? ["", "", "ä‽", "", "īø"] : (state == "marks") ? ["", "", "a!", "", ""] : ["", "", "", "", "a!"]
    iconNormal: panel.state == "CHARACTERS" ? ["language-chooser", "", "", "", ""] : (state == "marks") ? ["settings", "", "", "", ""] : ["navigation-menu", "", "", "", ""]
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
            if (maliit_input_method.previousLanguage && maliit_input_method.previousLanguage != maliit_input_method.activeLanguage && panel.state == "CHARACTERS") {
                maliit_input_method.activeLanguage = maliit_input_method.previousLanguage;
            } else if(panel.state == "ACCENTS") {
                        if (state == "marks"){
                            Qt.openUrlExternally("settings:///system/language");
                            maliit_input_method.hide();
                        }else {
                            canvas.languageMenuShown = true;
                        }
            } else {
                canvas.languageMenuShown = true;
            }
        } else if (index == 2) {
	    panel.state = (panel.state == "ACCENTS" && state =="marks") ? "CHARACTERS" : "ACCENTS";
        } else if (index == 3) {
            //panel.state = (panel.state != "EMOJI") ? "EMOJI" : "CHARACTERS";
		maliit_input_method.activeLanguage = "emoji";
        } else if (index == 4) {
	    if(panel.state == "ACCENTS" && state =="signs") panel.state = "CHARACTERS";
        }
    }
    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
            pressEffect.start();

    }
}
