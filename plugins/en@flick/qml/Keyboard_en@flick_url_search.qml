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
import keys 1.0

KeyPad {
 
    anchors.fill:parent;
    content: c1

    Column {
        id: c1
	anchors.fill:parent;
	property int keyHeight: panel.keyHeight-panel.keyHeight*0.1;
	spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0
	    CaseSwitchKey { id: layout; } 
            FlickCharKey {
                label: layout.state == "caps" ? "QER" : "qer";
                leaves: layout.state == "caps" ? ["1", "Q", "E", "R", ":"] : ["1", "q", "e", "r", ":"];
                annotation: layout.state == "caps" ? "1:" : "1:";
            }
            FlickCharKey {
                label: layout.state == "caps" ? "TYU" : "tyu";
                leaves: layout.state == "caps" ? ["2", "T", "Y", "U", "$"] : ["2", "t", "y", "u", "$"];
                annotation: layout.state == "caps" ? "2$" : "2$";
            }
            FlickCharKey {
                label: layout.state == "caps" ? "IOP" : "iop";
                leaves: layout.state == "caps" ? ["3", "I", "O", "P", "#"] : ["3", "i", "o", "p", "#"];
                annotation: layout.state == "caps" ? "3#" : "3#";
            }
            BackspaceKey { rightSide: true; width: panel.keyWidth; height:layout.height;}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey { leftSide:true; }
            FlickCharKey {
                label: layout.state == "caps" ? "AWD" : "awd";
                leaves: layout.state == "caps" ? ["4", "A", "W", "D", "S"] : ["4", "a", "w", "d", "s"];
                annotation: layout.state == "caps" ? "4S" : "4s";
            }
            FlickCharKey {
                label: layout.state == "caps" ? "(F)" : "(f)";
                leaves: layout.state == "caps" ? ["5", "(", "F", ")", "G"] : ["5", "(", "f", ")", "g"];
                annotation: layout.state == "caps" ? "5G" : "5g";
            }
            FlickCharKey {
                label: layout.state == "caps" ? "HKL" : "hkl";
                leaves: layout.state == "caps" ? ["6", "H", "K", "L", "J"] : ["6", "h", "k", "l", "j"];
                annotation: layout.state == "caps" ? "6J" : "6j";
            }
            CursorKey { rightSide:true; }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0
           
            FlickCharKey {
                label: layout.state == "caps" ? "`_" : "`_"
                leaves: layout.state == "caps" ? ["=", "", "`", "_", "|"] : ["=", "", "`", "_", "|"]
                annotation: layout.state == "caps" ? "=|" : "=|"
            }
	     FlickCharKey {
                label: layout.state == "caps" ? "ZXC" : "zxc"
                leaves: layout.state == "caps" ? ["7", "Z", "X", "C", "\\"] : ["7", "z", "x", "c", "\\"]
                annotation: layout.state == "caps" ? "7\\" : "7\\"
            }
            FlickCharKey {
                label: layout.state == "caps" ? "[*]" : "[*]"
                leaves: layout.state == "caps" ? ["8", "[", "*", "]", "V"] : ["8", "[", "*", "]", "v"]
                annotation: layout.state == "caps" ? "8V" : "8v"
            }
            FlickCharKey {
                label: layout.state == "caps" ? "BNM" : "bnm"
                leaves: layout.state == "caps" ? ["9", "B", "N", "M", "/"] : ["9", "b", "n", "m", "/"]
                annotation: layout.state == "caps" ? "9/" : "9/"
            }
           FlickCharKey {
                label: layout.state == "caps" ? "&amp;!" : "&amp;!"
                leaves: layout.state == "caps" ? ["@", "&", "!", "", "~"] : ["@", "&", "!", "", "~"]
                annotation: layout.state == "caps" ? "@~" : "@~"
            }
	 }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            LanguageKey    { id: languageMenuButton; height:layout.height;}
            FlickCharKey {
   		 label: layout.state == "caps" ? "&lt; - >" : "&lt; - >"
   		 leaves: layout.state == "caps" ?  [",", "<", "-", ">", "+"]: [",", "<", "-", ">", "+"];
		 annotation: layout.state == "caps" ?  ",+" : ",+"
	    }
	    FlickCharKey {
                label: layout.state == "caps" ? "' ^ \"" : "' ^ \""
                leaves: layout.state == "caps" ? ["0", "'", "^", "\"", "%"] : ["0", "'", "^", "\"", "%"];
                annotation: layout.state == "caps" ? "0%" : "0%";
            }
            StringKey {
                label: layout.state == "caps" ? "{ ? }" : "<font size=\"5\">.io .com .org</font>";
                leaves: layout.state == "caps" ? [".", "{", "?", "}", ";"] :
                    [".", "<font size=\"6\">.io</font>", "<font size=\"6\">.com</font>", "<font size=\"6\">.org</font>","<font size=\"6\">.net</font>"];
                unstyledLeaves: layout.state == "caps" ? [".", "{", "?", "}",";"] : [".", ".io", ".com", ".org",".net"];
                annotation: layout.state == "caps" ? "." : ".net"
        }
	CommitKey    { id: enterKey; width: panel.keyWidth; height:layout.height;}
        }
	
    } // column
}
