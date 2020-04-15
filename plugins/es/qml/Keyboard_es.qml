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

			CharKey { label: "q"; shifted: "Q"; extended: ["1"]; extendedShifted: ["1"]; leftSide: true; }
			CharKey { label: "w"; shifted: "W"; extended: ["2"]; extendedShifted: ["2"] }
			CharKey { label: "e"; shifted: "E"; extended: ["é", "3"]; extendedShifted: ["É", "3"]; annotation: "3" }
			CharKey { label: "r"; shifted: "R"; extended: ["4"]; extendedShifted: ["4"] }
			CharKey { label: "t"; shifted: "T"; extended: ["5"]; extendedShifted: ["5"] }
			CharKey { label: "y"; shifted: "Y"; extended: ["6"]; extendedShifted: ["6"] }
			CharKey { label: "u"; shifted: "U"; extended: ["ú", "7","ü"]; extendedShifted: ["Ú","7","Ü"]; annotation: "7" }
			CharKey { label: "i"; shifted: "I"; extended: ["í", "8"]; extendedShifted: ["Í","8"], annotation: "8" }
			CharKey { label: "o"; shifted: "O"; extended: ["ó", "9","º"]; extendedShifted: ["Ó","9","º"]; annotation: "9" }
			CharKey { label: "p"; shifted: "P"; extended: ["0"]; extendedShifted: ["0"]; rightSide: true; }
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter;
			spacing: 0

			CharKey { label: "a"; shifted: "A"; extended: ["@","á","ª"]; extendedShifted: ["@","Á","ª"]; leftSide: true; }
			CharKey { label: "s"; shifted: "S"; extended: ["#"]; extendedShifted: ["#"] }
			CharKey { label: "d"; shifted: "D"; extended: ["&"]; extendedShifted: ["&"] }
			CharKey { label: "f"; shifted: "F"; extended: ["*"]; extendedShifted: ["*"] }
			CharKey { label: "g"; shifted: "G"; extended: ["-"]; extendedShifted: ["-"] }
			CharKey { label: "h"; shifted: "H"; extended: ["+"]; extendedShifted: ["+"] }
			CharKey { label: "j"; shifted: "J"; extended: ["="]; extendedShifted: ["="] }
			CharKey { label: "k"; shifted: "K"; extended: ["("]; extendedShifted: ["("] }
			CharKey { label: "l"; shifted: "L"; extended: [")"]; extendedShifted: [")"] }
			CharKey { label: "ñ"; shifted: "Ñ"; extended: ["%"]; extendedShifted: ["%"]; rightSide: true; }
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter;
			spacing: 0

			ShiftKey {}
			CharKey { label: "z"; shifted: "Z"; extended: ["_"]; extendedShifted: ["_"] }
			CharKey { label: "x"; shifted: "X"; extended: ["£","¢","$","¥","€"]; extendedShifted: ["£","¢","$","¥","€"]; annotation: "$" }
			CharKey { label: "c"; shifted: "C"; extended: ["\""]; extendedShifted: ["\""] }
			CharKey { label: "v"; shifted: "V"; extended: ["'"]; extendedShifted: ["'"] }
			CharKey { label: "b"; shifted: "B"; extended: [":"]; extendedShifted: [":"] }
			CharKey { label: "n"; shifted: "N"; extended: [";"]; extendedShifted: [";"] }
			CharKey { label: "m"; shifted: "M"; extended: ["/"]; extendedShifted: ["/"] }
			BackspaceKey {}
		}

		Item {
			anchors.left: parent.left
			anchors.right: parent.right

			height: panel.keyHeight + units.gu(UI.row_margin);

			SymbolShiftKey { id: symShiftKey;                            anchors.left: parent.left; height: parent.height; }
			LanguageKey    { id: languageMenuButton;                     anchors.left: symShiftKey.right; height: parent.height; }
			CharKey        { id: commaKey;    label: ","; shifted: ","; extended: [";", ":"];  extendedShifted: [";", ":"]; anchors.left: languageMenuButton.right; height: parent.height; }
			SpaceKey       { id: spaceKey;                               anchors.left: commaKey.right; anchors.right: dotKey.left; noMagnifier: true; height: parent.height; }
			CharKey        { id: dotKey;      label: "."; shifted: "."; extended: ["¡", "!", ".", "¿", "?"];  extendedShifted: ["¡", "!", ".", "¿", "?"]; anchors.right: enterKey.left; height: parent.height; annotation: "?"}
			ReturnKey      { id: enterKey;                               anchors.right: parent.right; height: parent.height; }
		}
	} // column
}
