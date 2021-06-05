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

            CharKey { valueToSubmit: "1"; annotation: valueToSubmit; label: "1"; shifted: "!"; leftSide: true; textCenterOffset: offset; }
            CharKey { valueToSubmit: "2"; annotation: valueToSubmit; label: "2"; shifted: "@"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "3"; annotation: valueToSubmit; label: "3"; shifted: "#"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "4"; annotation: valueToSubmit; label: "4"; shifted: "$"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "5"; annotation: valueToSubmit; label: "5"; shifted: "%"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "6"; annotation: valueToSubmit; label: "6"; shifted: "^"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "7"; annotation: valueToSubmit; label: "7"; shifted: "&"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "8"; annotation: valueToSubmit; label: "8"; shifted: "*"; textCenterOffset: offset; }
            CharKey { valueToSubmit: "9"; annotation: valueToSubmit; label: "9"; shifted: "("; textCenterOffset: offset; }
            CharKey { valueToSubmit: "0"; annotation: valueToSubmit; label: "10"; shifted: ")"; rightSide: true; textCenterOffset: offset; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CharKey { valueToSubmit: "q"; annotation: valueToSubmit; label: "手"; shifted: "Q"; extended: ["q"]; extendedShifted: ["q"]; leftSide: true; }
            CharKey { valueToSubmit: "w"; annotation: valueToSubmit; label: "田"; shifted: "W"; extended: ["w"]; extendedShifted: ["w"] }
            CharKey { valueToSubmit: "e"; annotation: valueToSubmit; label: "水"; shifted: "E"; extended: ["e"]; extendedShifted: ["e"] }
            CharKey { valueToSubmit: "r"; annotation: valueToSubmit; label: "口"; shifted: "R"; extended: ["r"]; extendedShifted: ["r"] }
            CharKey { valueToSubmit: "t"; annotation: valueToSubmit; label: "廿"; shifted: "T"; extended: ["t"]; extendedShifted: ["t"] }
            CharKey { valueToSubmit: "y"; annotation: valueToSubmit; label: "卜"; shifted: "Y"; extended: ["y"]; extendedShifted: ["y"] }
            CharKey { valueToSubmit: "u"; annotation: valueToSubmit; label: "山"; shifted: "U"; extended: ["u"]; extendedShifted: ["u"] }
            CharKey { valueToSubmit: "i"; annotation: valueToSubmit; label: "戈"; shifted: "I"; extended: ["i"]; extendedShifted: ["i"] }
            CharKey { valueToSubmit: "o"; annotation: valueToSubmit; label: "人"; shifted: "O"; extended: ["o"]; extendedShifted: ["o"] }
            CharKey { valueToSubmit: "p"; annotation: valueToSubmit; label: "心"; shifted: "P"; extended: ["p"]; extendedShifted: ["p"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CharKey { valueToSubmit: "a"; annotation: valueToSubmit; label: "日"; shifted: "A"; extended: ["a"]; extendedShifted: ["a"]; leftSide: true; }
            CharKey { valueToSubmit: "s"; annotation: valueToSubmit; label: "尸"; shifted: "S"; extended: ["s"]; extendedShifted: ["s"] }
            CharKey { valueToSubmit: "d"; annotation: valueToSubmit; label: "木"; shifted: "D"; extended: ["d"]; extendedShifted: ["d"] }
            CharKey { valueToSubmit: "f"; annotation: valueToSubmit; label: "火"; shifted: "F"; extended: ["f"]; extendedShifted: ["f"] }
            CharKey { valueToSubmit: "g"; annotation: valueToSubmit; label: "土"; shifted: "G"; extended: ["g"]; extendedShifted: ["g"] }
            CharKey { valueToSubmit: "h"; annotation: valueToSubmit; label: "竹"; shifted: "H"; extended: ["h"]; extendedShifted: ["h"] }
            CharKey { valueToSubmit: "j"; annotation: valueToSubmit; label: "十"; shifted: "J"; extended: ["j"]; extendedShifted: ["j"] }
            CharKey { valueToSubmit: "k"; annotation: valueToSubmit; label: "大"; shifted: "K"; extended: ["k"]; extendedShifted: ["k"] }
            CharKey { valueToSubmit: "l"; annotation: valueToSubmit; label: "中"; shifted: "L"; extended: ["l"]; extendedShifted: ["l"]; rightSide: true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            CharKey { valueToSubmit: "z"; annotation: valueToSubmit; label: "重"; shifted: "Z"; extended: ["z"]; extendedShifted: ["z"] }
            CharKey { valueToSubmit: "x"; annotation: valueToSubmit; label: "難"; shifted: "X"; extended: ["x"]; extendedShifted: ["x"] }
            CharKey { valueToSubmit: "c"; annotation: valueToSubmit; label: "金"; shifted: "C"; extended: ["c"]; extendedShifted: ["c"] }
            CharKey { valueToSubmit: "v"; annotation: valueToSubmit; label: "女"; shifted: "V"; extended: ["v"]; extendedShifted: ["v"] }
            CharKey { valueToSubmit: "b"; annotation: valueToSubmit; label: "月"; shifted: "B"; extended: ["b"]; extendedShifted: ["b"] }
            CharKey { valueToSubmit: "n"; annotation: valueToSubmit; label: "弓"; shifted: "N"; extended: ["n"]; extendedShifted: ["n"] }
            CharKey { valueToSubmit: "m"; annotation: valueToSubmit; label: "一"; shifted: "M"; extended: ["m"]; extendedShifted: ["m"] }
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
