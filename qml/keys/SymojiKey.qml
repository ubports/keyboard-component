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
    charlabel: (panel.state == "ACCENTS") ? ["", "", "", "", "abc"]:["", "", "ã｡", "", "āñ‽"]
    leaves: (panel.state == "ACCENTS") ? ["", "", "", "", "abc"]:["", "", "ã｡", "", "āñ‽"]
    iconNormal: ["language-chooser", "", "", "", ""]
    iconNormalSource: ["", "", "", "../images/happy.svg", ""]
    leavesFontSize: 30;
    shiftedlabel: charlabel
    shiftedleaves: leaves
    width: panel.keyWidth;
    action: "symbols";

    overridePressArea: true;

    onReleased: {
        if (index == 0) {
            if (maliit_input_method.previousLanguage && maliit_input_method.previousLanguage != maliit_input_method.activeLanguage && panel.state == "CHARACTERS") {
                maliit_input_method.activeLanguage = maliit_input_method.previousLanguage
            } else if(panel.state == "ACCENTS") {
                        Qt.openUrlExternally("settings:///system/language")
                        maliit_input_method.hide();
            } else {
                canvas.languageMenuShown = true
            }
        } else if (index == 2) {
            panel.state = (panel.activeKeypadState == "NORMAL") ? "ACCENTS" : "CHARACTERS";
            panel.activeKeypadState = (panel.activeKeypadState == "NORMAL" && panel.state == "ACCENTS") ? "CAPSLOCK" : "NORMAL";
        } else if (index == 3) {
            panel.state = (panel.state != "EMOJI") ? "EMOJI" : "CHARACTERS";
        } else if (index == 4) {
            if(panel.state == "ACCENTS" && panel.activeKeypadState == "CAPSLOCK"){
                panel.activeKeypadState = "NORMAL";
                panel.state = "ACCENTS";
            } else {
                panel.state = panel.state == "CHARACTERS" ? "ACCENTS" : "CHARACTERS";
            }
        }
    }
    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
            pressEffect.start();

    }
}