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
import "keys/"
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

            ACharKey { label: "q"; shifted: "Q"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
            ACharKey { label: "w"; shifted: "W"; extended: ["2"]; extendedShifted: ["2"] }
            ACharKey { label: "e"; shifted: "E"; extended: ["3"]; extendedShifted: ["3"] }
            ACharKey { label: "r"; shifted: "R"; extended: ["4"]; extendedShifted: ["4"] }
            ACharKey { label: "t"; shifted: "T"; extended: ["5"]; extendedShifted: ["5"] }
            ACharKey { label: "y"; shifted: "Y"; extended: ["6"]; extendedShifted: ["6"] }
            ACharKey { label: "u"; shifted: "U"; extended: ["7"]; extendedShifted: ["7"] }
            ACharKey { label: "i"; shifted: "I"; extended: ["8"]; extendedShifted: ["8"] }
            ACharKey { label: "o"; shifted: "O"; extended: ["9"]; extendedShifted: ["9"] }
            ACharKey { label: "p"; shifted: "P"; extended: ["0"]; extendedShifted: ["0"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ACharKey { label: "a"; shifted: "A"; leftSide: true; }
            ACharKey { label: "s"; shifted: "S"; }
            ACharKey { label: "d"; shifted: "D"; }
            ACharKey { label: "f"; shifted: "F"; }
            ACharKey { label: "g"; shifted: "G"; }
            ACharKey { label: "h"; shifted: "H"; }
            ACharKey { label: "j"; shifted: "J"; }
            ACharKey { label: "k"; shifted: "K"; }
            ACharKey { label: "l"; shifted: "L"; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            ACharKey { label: "z"; shifted: "Z"; }
            ACharKey { label: "x"; shifted: "X"; }
            ACharKey { label: "c"; shifted: "C"; }
            ACharKey { label: "v"; shifted: "V"; }
            ACharKey { label: "b"; shifted: "B"; }
            ACharKey { label: "n"; shifted: "N"; }
            ACharKey { label: "m"; shifted: "M"; }
            ABackspaceKey {}
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right

            height: panel.keyHeight + units.gu(UI.row_margin);

            SymbolShiftKey { id: symShiftKey;                            anchors.left: parent.left; height: parent.height; }
            LanguageKey    { id: languageMenuButton;                     anchors.left: symShiftKey.right; height: parent.height; }
            ACharKey        { id: slashKey; label: "/"; shifted: "/";     anchors.left: languageMenuButton.right; height: parent.height; }
            UrlKey         { id: urlKey; label: ".com"; extended: [".co.kr", ".or.kr", ".go.kr", ".ac.kr", ".kr"]; anchors.right: dotKey.left; height: parent.height; }
            ACharKey        { id: dotKey;      label: "."; shifted: "."; extended: ["?", "-", "_", "!", "+", "%","#","/"]; extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
