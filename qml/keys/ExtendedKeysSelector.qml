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

import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3

import "key_constants.js" as UI

KeyPopover {
    id: popover
    enabled: false

    property variant extendedKeysModel
    property alias keys: rowOfKeys.children
    property alias rowX: rowOfKeys.x
    property alias rowY: rowOfKeys.y

    property int __width: 0
    property string __commitStr: ""

    onExtendedKeysModelChanged: {
        if (extendedKeysModel && extendedKeysModel.length > 1) {
            // Place the first key in the middle of the model so that it gets
            // selected by default
            var middleKey = Math.floor(extendedKeysModel.length / 2);
            var reorderedModel = extendedKeysModel.slice(0); // Ensure the array is cloned
            reorderedModel.splice(extendedKeysModel.length % 2 == 0 ? middleKey : middleKey + 1, 0, extendedKeysModel[0]);
            reorderedModel.shift();
            keyRepeater.model = reorderedModel;
        } else {
            keyRepeater.model = extendedKeysModel
        }
    }

    onEnabledChanged: {
        canvas.extendedKeysShown = enabled
    }

    BorderImage {
        id: popoverBackground

        anchors.centerIn: anchorItem
        anchors.verticalCenterOffset: -units.dp(UI.popoverTopMargin)

        width: {
            if (rowOfKeys.width < keypad.keyWidth)
                return keypad.keyWidth;
            else
                return rowOfKeys.width;
        }

        height: rowOfKeys.height

        source: "../images/popover.sci"

        onXChanged: {

            if (x < UI.popoverEdgeMargin) {
                anchorItem.x += Math.abs(x) + UI.popoverEdgeMargin;
                return
            }

            var rightEdge = (x + width)
            if ( rightEdge > (panel.width - UI.popoverEdgeMargin)) {
                var diff = rightEdge - panel.width
                anchorItem.x -= diff + UI.popoverEdgeMargin;
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: closePopover();
    }

    Row {
        id: rowOfKeys
        anchors.centerIn: anchorItem
        anchors.verticalCenterOffset: -units.dp(UI.popoverTopMargin)

        Component.onCompleted: __width = 0

        Repeater {
            id: keyRepeater
            model: extendedKeysModel

            Item {
                id: key
                width: textCell.width + units.gu( UI.popoverCellPadding );

                height: panel.keyHeight;

                property alias commitStr: textCell.text
                property bool highlight: false
                opacity: highlight ? 1.0 : 0.6

                Text {
                    id: textCell
                    anchors.centerIn: parent;
                    text: modelData
                    font.family: UI.fontFamily
                    font.pixelSize: text.length > 2 ? units.gu( UI.smallFontSize ) : units.gu( UI.fontSize )
                    font.weight: Font.Light
                    color: key.highlight ? UI.selectionColor : UI.fontColor
                    Component.onCompleted: __width += (textCell.width + units.gu( UI.popoverCellPadding));
                }

                function commit(skipAutoCaps) {
                    key.highlight = false;
                    event_handler.onKeyPressed(modelData);
                    event_handler.onKeyReleased(modelData);
                    if (panel.autoCapsTriggered) {
                        panel.autoCapsTriggered = false;
                    } else if (!skipAutoCaps) {
                        if (popover.parent.activeKeypadState === "SHIFTED" && popover.parent.state === "CHARACTERS")
                            popover.parent.activeKeypadState = "NORMAL"
                    }
                    popover.closePopover();
                }
            }
        }
    }

    function enableMouseArea()
    {
        extendedKeysMouseArea.enabled = true
    }

    function __restoreAssignedKey()
    {
        currentlyAssignedKey.state = "NORMAL"
    }

    function closePopover()
    {
        extendedKeysModel = null;
        // Forces re-evaluation of anchor position, in case we change
        // orientation and then open the popover for the same key again
        currentlyAssignedKey = null;
        popover.enabled = false
    }
}


