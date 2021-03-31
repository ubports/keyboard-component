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
                charlabel: symojiKey.state == "marks" ?  ["ă", "ą", "ȧ", "ā", "ǎ"]:["1", "q", "e", "r", ":"];
                shiftedlabel:symojiKey.state == "marks" ? ["Ă", "Ą", "Ȧ", "Ā", "Ǎ"] :["1", "Q", "E", "R", ":"];
                leaves:charlabel;
                shiftedleaves:shiftedlabel;
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ŭ", "ų", "ṁ", "ū", "ǔ"] :["2", "t", "y", "u", "g"];
                shiftedlabel: symojiKey.state == "marks" ? ["Ŭ", "Ų", "Ṁ", "Ū", "Ǔ"] :["2", "T", "Y", "U", "G"];
                leaves:charlabel;
                shiftedleaves:shiftedlabel;
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ŏ", "ǫ", "ȯ", "ō", "ǒ"] :["3", "i", "o", "m", ";"];
                shiftedlabel: symojiKey.state == "marks" ? ["Ŏ", "Ǫ", "Ȯ", "Ō", "Ǒ"] :["3", "I", "O", "M", ";"]
                leaves:charlabel;
                shiftedleaves:shiftedlabel;
            }
            CaseSwitchKey { id: layout; labelright:true}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ω", "", "ɛ", "д", "ɵ"] : ["#", "", "+", "@", "-"]
                shiftedlabel: symojiKey.state == "marks" ? ["Ω", "", "Ɛ", "Д", "Ɵ"] : charlabel
                labelleft:true
                leaves: charlabel
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ĕ", "ę", "ė", "ē", "ě"] :["4", "a", "w", "d", "s"];
                shiftedlabel: symojiKey.state == "marks" ? ["Ĕ", "Ę", "Ė", "Ē", "Ě"] :["4", "A", "W", "D", "S"];
                leaves: charlabel;
                shiftedleaves: shiftedlabel;
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ĭ", "į", "ḃ", "ī", "ǐ"] :["5", "b", "p", "f", "n"];
                shiftedlabel: symojiKey.state == "marks" ? ["Ĭ", "Į", "Ḃ", "Ī", "Ǐ"] :["5", "B", "P", "F", "N"];
                leaves: charlabel;
                shiftedleaves: shiftedlabel;
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ?  ["đ", "ķ", "ẏ", "ȳ", "ď"]:["6", "h", "k", "l", "j"];
                shiftedlabel: symojiKey.state == "marks" ? ["Đ", "Ķ", "Ẏ", "Ȳ", "Ď"] :["6", "H", "K", "L", "J"];
                leaves: charlabel;
                shiftedleaves: shiftedlabel;
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["þ", "ŋ", "æ", "", "œ"] : ["*", "€", "^", "", "$"]
                shiftedlabel: symojiKey.state == "marks" ? ["Þ", "Ŋ", "Æ", "", "Œ"] : charlabel
                labelright:true
                leaves: charlabel
                shiftedleaves: shiftedlabel
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey { leftSide:true; padding:0; }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ğ", "å", "ġ", "ǵ", "ǧ"] : ["7", "]", "!", "[", "\\"]
                shiftedlabel: symojiKey.state == "marks" ? ["Ğ", "Å", "Ġ", "Ǵ", "Ǧ"] : charlabel
                leaves: charlabel
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ł", "ļ", "ṗ", "ĺ", "ľ"] :["8", "z", "x", "c", "v"]
                shiftedlabel: symojiKey.state == "marks" ? ["Ł", "Ļ", "Ṗ", "Ĺ", "Ľ"] :["8", "Z", "X", "C", "V"];
                leaves: charlabel
                shiftedleaves: shiftedlabel;
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ű", "ů", "ż", "ź", "ž"] : ["9", ")", "?", "(", "/"]
                shiftedlabel: symojiKey.state == "marks" ? ["Ű", "Ů", "Ż", "Ź", "Ž"] : charlabel
                leaves: charlabel
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ŧ", "ţ", "ṫ", "", "ť"] : ["=", "₹", "£", "", "¥"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ŧ", "Ţ", "Ṫ", "", "Ť"] : charlabel
                shiftedleaves: shiftedlabel
            }
         }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            SymojiKey { id: symojiKey;}
            FlickCharKey {
                 charlabel: symojiKey.state == "marks" ? ["ø", "ŗ", "ṙ", "ŕ", "ř"] : [",", ">", "&amp;", "&lt;", "_"]
                 shiftedlabel:  symojiKey.state == "marks" ? ["Ø", "Ŗ", "Ṙ", "Ŕ", "Ř"] : charlabel
                 leaves: charlabel
                 shiftedleaves:shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ő", "ç", "ċ", "ć", "č"] : ["0", "'", "`", "\"", "%"]
                shiftedlabel: symojiKey.state == "marks" ? ["Ő", "Ç", "Ċ", "Ć", "Č"] : charlabel
                leaves: charlabel
                shiftedleaves: shiftedlabel
            }
            StringKey {
                charlabel: symojiKey.state == "marks" ? ["ə", "ş", "ṡ", "ś", "š"] : [".", "<font size\"4\">.io</font>", "<font size=\"4\">.com</font>", "<font size=\"4\">.org</font>","<font size=\"4\">.net</font>"]
                shiftedlabel: symojiKey.state == "marks" ? ["Ə", "Ş", "Ṡ", "Ś", "Š"] : [".", "}", "#", "{", "~"];
                leaves: symojiKey.state == "marks" ? charlabel : [".", "<font size=\"4\">.io", "<font size=\"4\">.com</font>", "<font size=\"4\">.org</font>","<font size=\"4\">.net</font>"]
                shiftedleaves: symojiKey.state == "marks" ? shiftedlabel : [".", "}", "#", "{", "~"];
                unstyledLeaves: symojiKey.state == "marks" ? shiftedlabel : (panel.activeKeypadState === "NORMAL") ? [".", ".io", ".com", ".org",".net"]: shiftedlabel;
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
