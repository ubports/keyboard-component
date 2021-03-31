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
            ActionKey{width:panel.keyWidth;height:layout.height;visHeight:height}
            FlickCharKey {
                charlabel: ["ã", "à", "â", "á", "ä"];
                leaves: charlabel
                shiftedlabel: ["Ã", "À", "Â", "Á", "Ä"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["ũ", "ù", "û", "ú", "ü"];
                leaves: charlabel
                shiftedlabel: ["Ũ", "Ù", "Û", "Ú", "Ü"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["õ", "ò", "ô", "ó", "ö"];
                leaves: charlabel
                shiftedlabel: ["Õ", "Ò", "Ô", "Ó", "Ö"];
                shiftedleaves: shiftedlabel
            }
            CaseSwitchKey { id: layout; labelright:true}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            FlickCharKey {
                charlabel: ["√", "", "±", "÷", "×"]
                labelleft:true
                leaves: charlabel
                shiftedlabel: ["✿", "", "∆", "｡", "﹏"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["ẽ", "è", "ê", "é", "ë"];
                leaves: charlabel
                shiftedlabel: ["Ẽ", "È", "Ê", "É", "Ë"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["ĩ", "ì", "î", "í", "ï"];
                leaves: charlabel
                shiftedlabel: ["Ĩ", "Ì", "Î", "Í", "Ï"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["ỹ", "ỳ", "ŷ", "ý", "ÿ"];
                leaves: charlabel
                shiftedlabel: ["Ỹ", "Ỳ", "Ŷ", "Ý", "Ÿ"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["¢", "™", "©", "", "®"];
                labelright:true
                leaves: charlabel
                shiftedlabel: ["ʖ", "๑", " ͡", "", " ͜"];
                shiftedleaves: shiftedlabel

            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey { leftSide:true; padding: 0 }
            FlickCharKey {
                charlabel: ["–", "§", "¦", "ß", "⸘"]
                leaves: charlabel
                shiftedlabel: ["ง", "ᕙ", "∀", "ᕗ", "⊸"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["ñ", "ņ", "ṅ", "ń", "ň"]
                leaves: charlabel
                shiftedlabel: ["Ñ", "Ń", "Ṅ", "Ņ", "Ň"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["—", "ſ", "‽", "ı", "ð"]
                leaves: charlabel
                shiftedlabel: ["ﾉ", "≧", "人", "≦", "ڡ"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["¤", "♪", "☆", "", "✧"]
                leaves: charlabel
                shiftedlabel: ["•", "ẙ", "·", "", "∴"];
                shiftedleaves: shiftedlabel
            }
         }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            SymojiKey { id: symojiKey;}

            FlickCharKey {
                charlabel: ["„", "»", "‾", "«", "¿"]
                leaves: charlabel
                shiftedlabel: ["つ", "’̀", "ﾂ", "‘́", "ヮ"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["≠", "“", "´", "”", "‰"]
                leaves: charlabel
                shiftedlabel: ["∇", "╰", "「", "╯", "┐"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: ["…", "ª", "¨", "°", "¡"]
                leaves: charlabel
                shiftedlabel: ["∠", "☜", "ﾟ", "☞", "」"];
                shiftedleaves: shiftedlabel
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
