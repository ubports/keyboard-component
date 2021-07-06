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

import QtQuick 2.4
import keys 1.0

import "avrolib.js" as Parser

ActionKey {
    iconNormal: "erase";
    iconShifted: "erase";
    iconCapsLock: "erase";
    action: "backspace";

    property string preedit: maliit_input_method.preedit
    property string avrotmp: fullScreenItem.avrotmp
    property string m_preedit: ""
    property string syllable_preedit: ""
    property string last_preedit: ""
    property bool isPreedit: preedit != ""
    property bool isAvrotmp: avrotmp != ""

    overridePressArea: true;

    onReleased: {
          if (isPreedit) {
              fullScreenItem.avrotmp = avrotmp.substring(0, avrotmp.length - 1);
              maliit_input_method.preedit = Parser.OmicronLab.Avro.Phonetic.parse(fullScreenItem.avrotmp);
        } else {
             event_handler.onKeyReleased("", action);
        }
    }

    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
            pressEffect.start();

        if (!isPreedit) {
            event_handler.onKeyPressed("", action);
        }
    }

    onPressAndHold: {
        return;
    }


}
