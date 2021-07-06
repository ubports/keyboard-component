/*
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
import QtMultimedia 5.0
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import keys 1.0
import "key_constants.js" as UI
import "avrolib.js" as Parser
import "autocorrect.js" as Database

CharKey {

    allowPreeditHandler: true
    preeditHandler: handler

    Item {
        id: handler
        property var avrotmp: "" 

        function onKeyReleased(keyString, action) {
            // get previous avrotmp string
            if (maliit_input_method.preedit) {
                if (fullScreenItem.avrotmp) {
                     var prevtmp = fullScreenItem.avrotmp
                } else {
                     var prevtmp = "";
                }
            } else {
                fullScreenItem.avrotmp = ""
                var prevtmp = "";
            }
            var englishtext = prevtmp + keyString;
            fullScreenItem.avrotmp = englishtext;
            avrotmp = englishtext; 

            if (Database.db[englishtext]) {
                englishtext = Database.db[englishtext];
            }

            maliit_input_method.preedit = Parser.OmicronLab.Avro.Phonetic.parse(englishtext);
            return;
        }
    }
}
