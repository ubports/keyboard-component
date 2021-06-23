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
import keys 1.0

KeyPad {
    anchors.fill: parent

    content: c1
    symbols: "languages/Keyboard_symbols.qml"

    Column {
        id: c1
        anchors.fill: parent
        spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CharKey { label: "ქ"; shifted: "Q"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
            CharKey { label: "წ"; shifted: "ჭ"; extended: ["2"]; extendedShifted: ["2"] }
            CharKey { label: "ე"; shifted: "E"; extended: ["3"]; extendedShifted: ["3"] }
            CharKey { label: "რ"; shifted: "ღ"; extended: ["4"]; extendedShifted: ["4"] }
            CharKey { label: "ტ"; shifted: "თ"; extended: ["5"]; extendedShifted: ["5"] }
            CharKey { label: "ყ"; shifted: "Y"; extended: ["6"]; extendedShifted: ["6"] }
            CharKey { label: "უ"; shifted: "U"; extended: ["7"]; extendedShifted: ["7"] }
            CharKey { label: "ი"; shifted: "I"; extended: ["8"]; extendedShifted: ["8"] }
            CharKey { label: "ო"; shifted: "O"; extended: ["9"]; extendedShifted: ["9"] }
            CharKey { label: "პ"; shifted: "P"; extended: ["0"]; extendedShifted: ["0"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CharKey { label: "ა"; shifted: "A"; leftSide: true; }
            CharKey { label: "ს"; shifted: "შ"; extended: ["$"]; extendedShifted: ["$"] }
            CharKey { label: "დ"; shifted: "D"; }
            CharKey { label: "ფ"; shifted: "F"; }
            CharKey { label: "გ"; shifted: "G"; }
            CharKey { label: "ჰ"; shifted: "H"; }
            CharKey { label: "ჯ"; shifted: "ჟ"; }
            CharKey { label: "კ"; shifted: "K"; }
            CharKey { label: "ლ"; shifted: "L"; extended: ["₾"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            CharKey { label: "ზ"; shifted: "ძ"; }
            CharKey { label: "ხ"; shifted: "X"; }
            CharKey { label: "ც"; shifted: "ჩ"; }
            CharKey { label: "ვ"; shifted: "V"; }
            CharKey { label: "ბ"; shifted: "B"; }
            CharKey { label: "ნ"; shifted: "N"; }
            CharKey { label: "მ"; shifted: "M"; }
            BackspaceKey {}
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right

            height: panel.keyHeight + units.gu(UI.row_margin);

            SymbolShiftKey { id: symShiftKey;                            anchors.left: parent.left; height: parent.height; }
            LanguageKey    { id: languageMenuButton;                     anchors.left: symShiftKey.right; height: parent.height; }
            CharKey        { id: commaKey;    label: ","; shifted: ","; extended: ["'", "\"", ";", ":", "@", "&", "(", ")"]; extendedShifted: ["'", "\"", ";", ":", "@", "&", "(", ")"]; anchors.left: languageMenuButton.right; height: parent.height; }
            SpaceKey       { id: spaceKey;                               anchors.left: commaKey.right; anchors.right: dotKey.left; noMagnifier: true; height: parent.height; }
            CharKey        { id: dotKey;      label: "."; shifted: "."; extended: ["?", "-", "_", "!", "+", "%","#","/"];  extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
