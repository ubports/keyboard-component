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

    anchors.fill: parent;
    content: c1
    Column {
        id: c1
	property int keyHeight: panel.keyHeight-panel.keyHeight*0.1
        anchors.fill: parent;
	spacing: 0

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0
	    ActionKey    { id: enterKey; width: panel.keyWidth; visHeight:layout.height;height:layout.height;}

     FlickCharKey {
                charlabel: layout.state == "caps" ? ["1", "Q", "E", "R", ":"] : ["1", "q", "e", "r", ":"];
                leaves: layout.state == "caps" ? ["1", "Q", "E", "R", ":"] : ["1", "q", "e", "r", ":"];
            }
            FlickCharKey {
                charlabel: layout.state == "caps" ? ["2", "T", "Y", "U", "G"] : ["2", "t", "y", "u", "g"];
		leaves: layout.state == "caps" ? ["2", "T", "Y", "U", "G"] : ["2", "t", "y", "u", "g"];
            }
            FlickCharKey {
                charlabel: layout.state == "caps" ? ["3", "I", "O", "M", ";"] : ["3", "i", "o", "m", ";"];
		leaves: layout.state == "caps" ? ["3", "I", "O", "M", ";"] : ["3", "i", "o", "m", ";"];
            }
            CaseSwitchKey { id: layout; labelright:true}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            FlickCharKey {
                charlabel:  ["=", "", "!", "&amp;", "|"]
		labelleft:true
                leaves: layout.state == "caps" ? ["=", "", "!", "&", "|"] : ["=", "", "!", "&", "|"]
            }
            FlickCharKey {
                charlabel: layout.state == "caps" ? ["4", "A", "W", "D", "S"] : ["4", "a", "w", "d", "s"];
                leaves: layout.state == "caps" ? ["4", "A", "W", "D", "S"] : ["4", "a", "w", "d", "s"];
            }
            FlickCharKey {
                charlabel: layout.state == "caps" ? ["5", "B", "P", "F", "N"] : ["5", "b", "p", "f", "n"];
                leaves: layout.state == "caps" ? ["5", "B", "P", "F", "N"] : ["5", "b", "p", "f", "n"];
            }
            FlickCharKey {
                charlabel: layout.state == "caps" ? ["6", "H", "K", "L", "J"] : ["6", "h", "k", "l", "j"];
                leaves: layout.state == "caps" ? ["6", "H", "K", "L", "J"] : ["6", "h", "k", "l", "j"];
            }
            FlickCharKey {
                charlabel: ["~", "_", "^", "", "$"]
		labelright:true
                leaves: ["~", "_", "^", "", "$"]

            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey {id:cursorKey; leftSide:true}
	    FlickCharKey {
                charlabel: layout.state == "caps" ? ["7", "]", "*", "[", "\\"] : ["7", "]", "*", "[", "\\"]
		leaves: ["7", "]", "*", "[", "\\"]
            }
            FlickCharKey {
                charlabel: layout.state == "caps" ? ["8", "Z", "X", "C", "V"] : ["8", "z", "x", "c", "v"]
		leaves: layout.state == "caps" ? ["8", "Z", "X", "C", "V"] : ["8", "z", "x", "c", "v"]
            }
            FlickCharKey {
                charlabel: ["9", ")", "?", "(", "/"]
                leaves: ["9", ")", "?", "(", "/"]
            }
           CursorKey { rightSide:true; }
	 }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

	LanguageKey {  width: panel.keyWidth; visHeight:layout.height;}
            FlickCharKey {
		 charlabel: [",", ">", "+", "&lt;", "-"]
		 leaves: [",", ">", "+", "<", "-"]
	    }
	    FlickCharKey {
                charlabel: ["0", "'", "`", "\"", "%"]
                leaves: ["0", "'", "`", "\"", "%"]
            }
            FlickCharKey {
                charlabel: [".", "}", "#", "{", "@"]
		leaves: [".", "}", "#", "{", "@"]
	    }
            BackspaceKey { rightSide: true; width: panel.keyWidth;visHeight:layout.height;}
	}

   } // column
	Row{
	 anchors.horizontalCenter: parent.horizontalCenter;
	 anchors.left:parent.left
	 anchors.bottom:parent.bottom
	 spacing: 0

	SpaceKey{
		id: spaceKey
		width:parent.width
		height:layout.height-layout.height*0.5
		visHeight:spaceKey.height
		fontSize:spaceKey.height

	     }
     }
}
