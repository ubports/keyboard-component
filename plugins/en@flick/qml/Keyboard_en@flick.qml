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
            ActionKey{
                width:panel.keyWidth;
                height:layout.height;
                visHeight:height;
                pressedColor: fullScreenItem.theme.actionKeyColor
            }
            FlickCharKey {
                charlabel:["1", "q", "e", "r", ":"];
                shiftedlabel:["1", "Q", "E", "R", ":"];
                leaves:["1", "q", "e", "r", ":"];
                shiftedleaves:["1", "Q", "E", "R", ":"];
            }
            FlickCharKey {
                charlabel:["2", "t", "y", "u", "g"];
                shiftedlabel:["2", "T", "Y", "U", "G"];
                leaves:["2", "t", "y", "u", "g"];
                shiftedleaves:["2", "T", "Y", "U", "G"];
            }
            FlickCharKey {
                charlabel:["3", "i", "o", "m", ";"];
                shiftedlabel:["3", "I", "O", "M", ";"]
                leaves:["3", "i", "o", "m", ";"];
                shiftedleaves:["3", "I", "O", "M", ";"];
            }
            BackspaceKey { rightSide: true; width: panel.keyWidth;height:layout.height;}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            FlickCharKey {
                charlabel:  ["#", "", "+", "~", "-"]
                shiftedlabel:charlabel
                labelleft:true
                leaves: ["#", "", "+", "~", "-"]
                shiftedleaves:leaves
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
            FlickCharKey {
                label: layout.state == "caps" ? "&amp;`" : "&amp;`"
                leaves: layout.state == "caps" ? [";", "&", "`", "", "~"] : [";", "&", "`", "", "~"]
		annotation: layout.state == "caps" ? ";~" : ";~"
                charlabel:["4", "a", "w", "d", "s"];
                shiftedlabel:["4", "A", "W", "D", "S"];
                leaves:["4", "a", "w", "d", "s"];
                shiftedleaves:["4", "A", "W", "D", "S"];
            }
            FlickCharKey {
                charlabel:["5", "b", "p", "f", "n"];
                shiftedlabel:["5", "B", "P", "F", "N"];
                leaves:["5", "b", "p", "f", "n"];
                shiftedleaves:["5", "B", "P", "F", "N"];
            }
            FlickCharKey {
                charlabel:["6", "h", "k", "l", "j"];
                shiftedlabel:["6", "H", "K", "L", "J"];
                leaves:["6", "h", "k", "l", "j"];
                shiftedleaves:["6", "H", "K", "L", "J"];
            }
            FlickCharKey {
                charlabel: ["*", "€", "^", "", "$"]
                shiftedlabel:charlabel
                labelright:true
                leaves: ["*", "€", "^", "", "$"]
                shiftedleaves:leaves
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey { leftSide:true; padding:0; }
            FlickCharKey {
                charlabel: ["7", "]", "!", "[", "\\"]
                shiftedlabel:charlabel
                leaves: ["7", "]", "!", "[", "\\"]
                shiftedleaves:leaves
            }
            FlickCharKey {
                charlabel:["8", "z", "x", "c", "v"]
                shiftedlabel:["8", "Z", "X", "C", "V"];
                leaves:["8", "z", "x", "c", "v"]
                shiftedleaves:["8", "Z", "X", "C", "V"];
            }
            FlickCharKey {
                charlabel: ["9", ")", "?", "(", "/"]
                shiftedlabel: charlabel
                leaves: ["9", ")", "?", "(", "/"]
                shiftedleaves:leaves
            }
            FlickCharKey {
                charlabel: ["=", "₹", "£", "", "¥"]
                shiftedlabel:charlabel
                leaves: ["=", "₹", "£", "", "¥"]
                shiftedleaves:leaves
            }
         }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            SymojiKey { id: symojiKey;}
            FlickCharKey {
                 charlabel: [",", ">", "&amp;", "&lt;", "_"]
                 shiftedlabel:charlabel
                 leaves: [",", ">", "&", "<", "_"]
                 shiftedleaves:leaves
            }
            FlickCharKey {
                charlabel: ["0", "'", "`", "\"", "%"]
                shiftedlabel:charlabel
                leaves: ["0", "'", "`", "\"", "%"]
                shiftedleaves:leaves
            }
            FlickCharKey {
                charlabel: [".", "}", "|", "{", "@"]
                shiftedlabel:charlabel
                leaves: [".", "}", "|", "{", "@"]
                shiftedleaves:leaves
            }
            BackspaceKey { rightSide: true; width: panel.keyWidth;visHeight:layout.height;}
        }

   } // column
        Row{
         anchors.horizontalCenter: parent.horizontalCenter;
         anchors.left:parent.left
         anchors.bottom:parent.bottom
         spacing: 0

            LayoutBar {
                id: layoutBar;
                width: parent.width;
                height:layout.height-layout.height*0.5;
                visHeight:height;
                fontSize:fontSize;
            }

     }
}
