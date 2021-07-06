/*
 * Copyright 2013 Canonical Ltd.
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

            CharKey { label: "১"; shifted: "১"; }
            CharKey { label: "২"; shifted: "২"; }
            CharKey { label: "৩";  shifted: "৩"; }
            CharKey { label: "৪";  shifted: "৪"; }
            CharKey { label: "৫";  shifted: "৫"; }
            CharKey { label: "৬";  shifted: "৬"; }
            CharKey { label: "৭";  shifted: "৭"; }
            CharKey { label: "৮";  shifted: "৮"; }
            CharKey { label: "৯";  shifted: "৯"; }
            CharKey { label: "০";  shifted: "০"; }
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CharKey { label: "দ"; extended: ["ধ"]; shifted: "ঢ"; }
            CharKey { label: "ূ"; extended: ["ঊ"]; shifted: "ঊ"; }
            CharKey { label: "ী"; extended: ["ঈ"]; shifted: "ঈ"; }
            CharKey { label: "র"; extended: ["ড়"]; shifted: "ড়"; extendedShifted: ["র্"]; }
            CharKey { label: "ট"; extended: ["ঠ"]; shifted: "ঠ"; }
            CharKey { label: "এ"; extended: ["ঐ"]; shifted: "ঐ"; extendedShifted: ["ঞ"]; }
            CharKey { label: "ু"; extended: ["উ"]; shifted: "উ"; extendedShifted: ["ৎ"]; }
            CharKey { label: "ি"; extended: ["ই"]; shifted: "ই"; }
            CharKey { label: "ও"; extended: ["ঔ"]; shifted: "ঔ"; }
            CharKey { label: "প"; extended: ["ফ"]; shifted: "ফ"; }
            CharKey { label: "ে"; extended: ["ৈ"]; shifted: "ৈ"; }
            CharKey { label: "ো"; extended: ["ৌ"]; shifted: "ৌ"; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CharKey { label: "া"; extended: ["অ"]; shifted: "অ"; }
            CharKey { label: "স"; extended: ["ষ"]; shifted: "ষ"; }
            CharKey { label: "ড"; extended: ["ঢ"]; shifted: "ঢ"; }
            CharKey { label: "ত"; extended: ["থ"]; shifted: "থ"; }
            CharKey { label: "গ"; extended: ["ঘ"]; shifted: "ঘ"; }
            CharKey { label: "হ"; extended: ["ঃ"]; shifted: "ঃ"; }
            CharKey { label: "জ"; extended: ["ঝ"]; shifted: "ঝ"; }
            CharKey { label: "ক"; extended: ["খ"]; shifted: "খ"; }
            CharKey { label: "ল"; extended: ["ং"]; shifted: "ং"; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            ShiftKey {}
            CharKey { label: "য়"; extended: ["্য"]; shifted: "য"; extendedShifted: ["্য"]; }
            CharKey { label: "শ"; extended: ["ঢ়"]; shifted: "ঢ়"; }
            CharKey { label: "চ"; extended: ["ছ"]; shifted: "ছ"; }
            CharKey { label: "আ"; extended: ["ঋ"]; shifted: "ঝ"; }
            CharKey { label: "ব"; extended: ["ভ"]; shifted: "ভ"; }
            CharKey { label: "ন"; extended: ["ণ"]; shifted: "ণ"; }
            CharKey { label: "ম"; extended: ["ঙ"]; shifted: "ঙ"; }
            CharKey { label: "ৃ"; extended: [""]; shifted: "ৃ"; }
            CharKey { label: "্"; extended: ["ঁ"]; shifted: "্"; extendedShifted: ["ঁ"]; }
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
            CharKey        { id: dotKey;      label: "।"; shifted: "।"; extended: ["?", "-", "_", "!", "+", "%","#","/"];  extendedShifted: ["?", "-", "_", "!", "+", "%","#","/"]; anchors.right: enterKey.left; height: parent.height; }
            ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
        }
    } // column
}
