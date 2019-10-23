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

            CharKey { label: "b"; shifted: "B"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
            CharKey { label: "é"; shifted: "É"; extended: ["2"]; extendedShifted: ["2"] }
            CharKey { label: "p"; shifted: "P"; extended: ["3"]; extendedShifted: ["3"] }
            CharKey { label: "o"; shifted: "O"; extended: ["4", "ô","œ","ò","ó","õ"]; extendedShifted: ["4","Ô","Œ","Ò","Ó","Õ"] }
            CharKey { label: "è"; shifted: "È"; extended: ["5"]; extendedShifted: ["5"] }      
            CharKey { label: "v"; shifted: "V"; extended: ["6"]; extendedShifted: ["6"] }
            CharKey { label: "d"; shifted: "D"; extended: ["7"]; extendedShifted: ["7"] }
            CharKey { label: "l"; shifted: "L"; extended: ["8"]; extendedShifted: ["8"] }
            CharKey { label: "j"; shifted: "J"; extended: ["9"]; extendedShifted: ["9"] }
            CharKey { label: "z"; shifted: "Z"; extended: ["0"]; extendedShifted: ["0"]; }
            CharKey { label: "w"; shifted: "W"; rightSide: true;} 
            }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0
            CharKey { label: "a"; shifted: "A"; extended: ["à","â","æ","á","ã","ä"]; extendedShifted: ["À","Â","Æ","Á","Ã","Ä"]; leftSide: true; }
            CharKey { label: "u"; shifted: "U"; extended: ["û","ù","ú","ü"]; extendedShifted: ["Û","Ù","Ú","Ü"] }
            CharKey { label: "i"; shifted: "I"; extended: ["î","ï","ì","í"]; extendedShifted: ["Î","Ï","Ì","Í"] }
            CharKey { label: "e"; shifted: "E"; extended: ["ë","ê","€"]; extendedShifted: ["Ë","Ê","€"] }
            CharKey { label: "c"; shifted: "C"; extended: ["ç"]; extendedShifted: ["Ç"] }
            CharKey { label: "t"; shifted: "T"; }
            CharKey { label: "s"; shifted: "S"; extended: ["ß","$"]; extendedShifted: ["$"] }
            CharKey { label: "r"; shifted: "R"; }
            CharKey { label: "n"; shifted: "N"; extended: ["ñ"]; extendedShifted: ["Ñ"] }
            CharKey { label: "m"; shifted: "M"; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}

            CharKey { label: "y"; shifted: "Y"; extended: ["ÿ","¥"]; extendedShifted: ["Ÿ","¥"] }
            CharKey { label: "x"; shifted: "X"; }
            CharKey { label: "k"; shifted: "K"; }
            CharKey { label: "q"; shifted: "Q"; }
            CharKey { label: "g"; shifted: "G"; }
            CharKey { label: "h"; shifted: "H"; }
            CharKey { label: "f"; shifted: "F"; }
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
            CharKey        { id: dotKey;      label: "."; shifted: "."; extended: ["?", "-", "_", "!", "+", "%","#","/"]; extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
