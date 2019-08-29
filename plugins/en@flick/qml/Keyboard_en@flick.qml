/*
 * Copyright 2015 Canonical Ltd.
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

    Column {
        id: c1
        anchors.left: parent.left;
	anchors.right: parent.right;
 //       anchors.top: parent.top;
	anchors.bottom: parent.bottom;
   	anchors.bottomMargin:25;
	spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0
	    CaseSwitchKey { id: layout; }  
	    FlickCharKey {
                label: layout.state == "kana" ? "QER" : "qer";
                leaves: layout.state == "kana" ? ["1", "Q", "E", "R", ":"] : ["1", "q", "e", "r", ":"];
                annotation: layout.state == "kana" ? "1:" : "1:";
            }
            FlickCharKey {
                label: layout.state == "kana" ? "TYU" : "tyu";
                leaves: layout.state == "kana" ? ["2", "T", "Y", "U", "$"] : ["2", "t", "y", "u", "$"];
                annotation: layout.state == "kana" ? "2$" : "2$";
            }
            FlickCharKey {
                label: layout.state == "kana" ? "IOP" : "iop";
                leaves: layout.state == "kana" ? ["3", "I", "O", "P", "#"] : ["3", "i", "o", "p", "#"];
                annotation: layout.state == "kana" ? "3#" : "3#";
            }
            BackspaceKey { rightSide: true; width: panel.keyWidth; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey { action: "left"; }
            FlickCharKey {
                label: layout.state == "kana" ? "AWD" : "awd";
                leaves: layout.state == "kana" ? ["4", "A", "W", "D", "S"] : ["4", "a", "w", "d", "s"];
                annotation: layout.state == "kana" ? "4S" : "4s";
            }
            FlickCharKey {
                label: layout.state == "kana" ? "(F)" : "(f)";
                leaves: layout.state == "kana" ? ["5", "(", "F", ")", "G"] : ["5", "(", "f", ")", "g"];
                annotation: layout.state == "kana" ? "5G" : "5g";
            }
            FlickCharKey {
                label: layout.state == "kana" ? "HKL" : "hkl";
                leaves: layout.state == "kana" ? ["6", "H", "K", "L", "J"] : ["6", "h", "k", "l", "j"];
                annotation: layout.state == "kana" ? "6J" : "6j";
            }
            CursorKey { action: "right"; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0
           
            FlickCharKey {
                label: layout.state == "kana" ? "`_" : "`_"
                leaves: layout.state == "kana" ? [";", "", "`", "_", "|"] : [";", "", "`", "_", "|"]
                annotation: layout.state == "kana" ? ";|" : ";|"
            }
	     FlickCharKey {
                label: layout.state == "kana" ? "ZXC" : "zxc"
                leaves: layout.state == "kana" ? ["7", "Z", "X", "C", "\\"] : ["7", "z", "x", "c", "\\"]
                annotation: layout.state == "kana" ? "7\\" : "7\\"
            }
            FlickCharKey {
                label: layout.state == "kana" ? "[ * ]" : "[ * ]"
                leaves: layout.state == "kana" ? ["8", "[", "*", "]", "V"] : ["8", "[", "*", "]", "v"]
                annotation: layout.state == "kana" ? "8V" : "8v"
            }
            FlickCharKey {
                label: layout.state == "kana" ? "BNM" : "bnm"
                leaves: layout.state == "kana" ? ["9", "B", "N", "M", "/"] : ["9", "b", "n", "m", "/"]
                annotation: layout.state == "kana" ? "9/" : "9/"
            }
           FlickCharKey {
                label: layout.state == "kana" ? "&amp;!" : "&amp;!"
                leaves: layout.state == "kana" ? [",", "&", "!", "", "~"] : [",", "&", "!", "", "~"]
		annotation: layout.state == "kana" ? ",~" : ",~"
            }
	 }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

	LanguageKey {  width: panel.keyWidth; }	
           // CaseSwitchKey { id: layout2; } 
            ModifierKey { layoutState: layout.state; }
	    FlickCharKey {
                label: layout.state == "kana" ? "' ^ \"" : "' ^ \""
                leaves: layout.state == "kana" ? ["0", "'", "^", "\"", "%"] : ["0", "'", "^", "\"", "%"];
                annotation: layout.state == "kana" ? "0%" : "0%";
            }
            FlickCharKey {
                label: layout.state == "kana" ? "{ @ }" : "{ ? }";
                leaves: layout.state == "kana" ? [".", "{", "@", "}", "?"] : [".", "{", "?", "}", "@"];
                annotation: layout.state == "kana" ? ".@" : ".@";
            }
            CommitKey    { id: enterKey; width: panel.keyWidth; }
        }
     } // column
}
