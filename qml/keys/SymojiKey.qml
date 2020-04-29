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

import "key_constants.js" as UI

FlickActionKey {
    charlabel: (panel.state == "SYMBOLS") ? ["abc", "", "", "😀", ""]:["àþç", "", "", "😀", ""]
    leaves: (panel.state == "SYMBOLS") ? ["abc", "", "", "😀", ""]:["àþç", "", "", "😀", ""]
    leavesFontSize: 30;
    width: panel.keyWidth;
    action: "symbols";

    overridePressArea: true;

    onReleased: {
	    if (index == 0) {
		    panel.state = (panel.state == "CHARACTERS") ? "SYMBOLS" : "CHARACTERS";
	    } else if (index == 3) {
		    panel.state = (panel.state == "CHARACTERS") ? "EMOJI" : "CHARACTERS";
	    }
    }
    onPressed: {
        if (maliit_input_method.useAudioFeedback)
            audioFeedback.play();

        if (maliit_input_method.useHapticFeedback)
            pressEffect.start();

    }
}
