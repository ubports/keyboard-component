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
                charlabel: symojiKey.state == "marks" ?  ["ă", "ą", "ȧ", "ā", "ǎ"]: ["ã", "à", "â", "á", "ä"];
                leaves: charlabel
                shiftedlabel:symojiKey.state == "marks" ? ["Ă", "Ą", "Ȧ", "Ā", "Ǎ"] : ["Ã", "À", "Â", "Á", "Ä"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ŭ", "ų", "ṁ", "ū", "ǔ"] : ["ũ", "ù", "û", "ú", "ü"];
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ŭ", "Ų", "Ṁ", "Ū", "Ǔ"] : ["Ũ", "Ù", "Û", "Ú", "Ü"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ŏ", "ǫ", "ȯ", "ō", "ǒ"] : ["õ", "ò", "ô", "ó", "ö"];
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ŏ", "Ǫ", "Ȯ", "Ō", "Ǒ"] : ["Õ", "Ò", "Ô", "Ó", "Ö"];
                shiftedleaves: shiftedlabel
            }
            CaseSwitchKey { id: layout; labelright:true}
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ω", "", "ɛ", "д", "ɵ"] : ["√", "", "±", "÷", "×"]
                labelleft:true
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ω", "", "Ɛ", "Д", "Ɵ"] : ["✿", "", "∆", "｡", "﹏"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ĕ", "ę", "ė", "ē", "ě"] : ["ẽ", "è", "ê", "é", "ë"];
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ĕ", "Ę", "Ė", "Ē", "Ě"] : ["Ẽ", "È", "Ê", "É", "Ë"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ĭ", "į", "ḃ", "ī", "ǐ"] : ["ĩ", "ì", "î", "í", "ï"];
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ĭ", "Į", "Ḃ", "Ī", "Ǐ"] : ["Ĩ", "Ì", "Î", "Í", "Ï"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ?  ["đ", "ķ", "ẏ", "ȳ", "ď"]: ["ỹ", "ỳ", "ŷ", "ý", "ÿ"];
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Đ", "Ķ", "Ẏ", "Ȳ", "Ď"] : ["Ỹ", "Ỳ", "Ŷ", "Ý", "Ÿ"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["þ", "ŋ", "æ", "", "œ"] : ["‾", "™", "©", "", "®"];
                labelright:true
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Þ", "Ŋ", "Æ", "", "Œ"] : ["ʖ", "๑", " ͡", "", " ͜"];
                shiftedleaves: shiftedlabel

            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            CursorKey { leftSide:true; padding: 0 }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ğ", "å", "ġ", "ǵ", "ǧ"] : ["–", "»", "—", "«", "…"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ğ", "Å", "Ġ", "Ǵ", "Ǧ"] : ["ง", "ᕙ", "∀", "ᕗ", "⊸"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ł", "ļ", "ṗ", "ĺ", "ľ"] : ["ñ", "ņ", "ṅ", "ń", "ň"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ł", "Ļ", "Ṗ", "Ĺ", "Ľ"] : ["Ñ", "Ń", "Ṅ", "Ņ", "Ň"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ű", "ů", "ż", "ź", "ž"] : ["¨", "♪", "¤", "☆", "✧"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ű", "Ů", "Ż", "Ź", "Ž"] : ["ﾉ", "≧", "人", "≦", "ڡ"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ŧ", "ţ", "ṫ", "", "ť"] : ["¢", "ſ", "ı", "", "ð"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ŧ", "Ţ", "Ṫ", "", "Ť"] : ["•", "ẙ", "·", "", "∴"];
                shiftedleaves: shiftedlabel
            }
         }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: 0

            SymojiKey { id: symojiKey;}

            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ø", "ŗ", "ṙ", "ŕ", "ř"] : ["≠", "§", "ª", "ß", "°"]
                leaves: charlabel
                shiftedlabel:  symojiKey.state == "marks" ? ["Ø", "Ŗ", "Ṙ", "Ŕ", "Ř"] : ["つ", "’̀", "ﾂ", "‘́", "ヮ"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ő", "ç", "ċ", "ć", "č"] : ["¦", "“", "‰", "”", "„"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ő", "Ç", "Ċ", "Ć", "Č"] : ["∇", "╰", "「", "╯", "┐"];
                shiftedleaves: shiftedlabel
            }
            FlickCharKey {
                charlabel: symojiKey.state == "marks" ? ["ə", "ş", "ṡ", "ś", "š"] : ["´", "¡", "‽", "¿", "⸘"]
                leaves: charlabel
                shiftedlabel: symojiKey.state == "marks" ? ["Ə", "Ş", "Ṡ", "Ś", "Š"] : ["∠", "☜", "ﾟ", "☞", "」"];
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
