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

import "key_constants.js" as UI

FlickCharKey {
    id: actionKeyRoot
    property string iconNormal: ""
    property string iconShifted: ""
    property string iconCapsLock: ""

    property string iconSource: ""
    property string iconSourceUp: ""
    property string iconSourceLeft: ""
    property string iconSourceRight: ""
    property string iconSourceDown: ""
    property string iconSourceShifted: ""
    property string iconSourceCapsLock: ""

    noMagnifier: true
    skipAutoCaps: true
    property int padding: UI.actionKeyPadding

    width: panel.keyWidth

    normalColor: fullScreenItem.theme.charKeyColor
    pressedColor: fullScreenItem.theme.actionKeyPressedColor
    borderColor: fullScreenItem.theme.actionKeyBorderColor

    // can be overwritten by keys
    property color colorNormal: fullScreenItem.theme.fontColor
    property color colorShifted: fullScreenItem.theme.fontColor
    property color colorCapsLock: fullScreenItem.theme.fontColor

    // Make it possible for the visible area of the key to differ from the
    // actual key size. This allows us to extend the touch area of the bottom
    // row of keys all the way to the bottom of the keyboard, whilst
    // maintaining the same visual appearance.
    Item {
	anchors.top: parent.top
	height: c1.keyHeight
	width: panel.keyWidth

	Rectangle {
	    id: buttonRect
	    color: key.currentlyPressed || key.highlight ? pressedColor : normalColor
	    anchors.fill: parent
	    anchors.leftMargin: key.leftSide ? (parent.width - panel.keyWidth) + key.keyMargin : key.keyMargin
	    anchors.rightMargin: key.rightSide ? (parent.width - panel.keyWidth) + key.keyMargin : key.keyMargin
	    anchors.bottomMargin: key.rowMargin
	    radius: units.dp(4)
	    border{
		width: borderEnabled ? units.gu(0.1) : 0
		color: borderColor
	    }

	    /// label of the key
	    //  the label is also the value subitted to the app
	    RowLayout {
		id: tapLeftTopCol
		anchors.left: parent.left
		spacing: 0

		ColumnLayout {
		    id: tapColumn
		    Layout.minimumWidth: isPortrait ? buttonRect.width/4 : buttonRect.width/3
		    Layout.alignment : Qt.AlignTop
		    spacing: 0

		    Icon {
			    id: iconImage
			    source: iconSource !== "" ? iconSource
							    : iconNormal ? "image://theme/%1".arg(iconNormal)
									 : ""
			    color: actionKeyRoot.colorNormal
			    anchors.horizontalCenter: parent.horizontalCenter
			    //horizontalAlignment: Text.AlignHCenter
			    visible: (label == "" && !panel.hideKeyLabels)
			    height: actionKeyRoot.fontSize
			    width: height
			}
		}

		ColumnLayout {
		    id: leftColumn
		    Layout.alignment: Qt.AlignVCenter
		    Layout.minimumWidth: isPortrait ? buttonRect.width/4 : buttonRect.width/6
		    Layout.preferredHeight: buttonRect.height
		    spacing: 0

		    Icon {
			    id: iconImageLeft
			    source: iconSourceLeft !== "" ? iconSourceLeft
							    : iconNormal ? "image://theme/%1".arg(iconNormal)
									 : ""
			    color: actionKeyRoot.colorNormal
			anchors.horizontalCenter: parent.horizontalCenter
			//horizontalAlignment: Text.AlignHCenter
			    visible: (label == "" && !panel.hideKeyLabels)
			    height: actionKeyRoot.fontSize
			    width: height
	}
		}

		ColumnLayout {
		  id: topColumn
		  Layout.minimumWidth: isPortrait ? buttonRect.width/4 : buttonRect.width/6
		  Layout.alignment : Qt.AlignTop
		  spacing: 0

		  Icon {
			    id: iconImageUp
			    source: iconSourceUp !== "" ? iconSourceUp
							    : iconNormal ? "image://theme/%1".arg(iconNormal)
									 : ""
			    color: actionKeyRoot.colorNormal
			    anchors.horizontalCenter: parent.horizontalCenter
			    //horizontalAlignment: Text.AlignHCenter

			    visible: (label == "" && !panel.hideKeyLabels)
			    height: actionKeyRoot.fontSize
			    width: height
			}
		}
	    }

	    RowLayout {
		id: bottomRightCol
		anchors.right: parent.right
		spacing: 0

		ColumnLayout {
		    id: bottomColumn
		    Layout.minimumWidth: isPortrait ? buttonRect.width/4 : buttonRect.width/6
		    Layout.alignment : Qt.AlignBottom
		    spacing: 0

		    Icon {
			    id: iconImageDown
			    source: iconSourceDown !== "" ? iconSourceDown
							    : iconNormal ? "image://theme/%1".arg(iconNormal)
									 : ""
			    color: actionKeyRoot.colorNormal
			    anchors.horizontalCenter: parent.horizontalCenter
			    //horizontalAlignment: Text.AlignHCenter
			    anchors.bottom: parent.bottom
			    anchors.bottomMargin: units.gu(0.25)
			    visible: (label == "" && !panel.hideKeyLabels)
			    height: actionKeyRoot.fontSize
			    width: height
			}
		}

		ColumnLayout {
		    id: rightColumn
		    Layout.alignment: Qt.AlignVCenter
		    Layout.minimumWidth: isPortrait ? buttonRect.width/4 : buttonRect.width/6
		    Layout.preferredHeight: buttonRect.height
		    spacing: 0

		    Icon {
			    id: iconImageRight
			    source: iconSourceRight !== "" ? iconSourceRight
							    : iconNormal ? "image://theme/%1".arg(iconNormal)
									 : ""
			    color: actionKeyRoot.colorNormal
			    anchors.horizontalCenter: parent.horizontalCenter
			    //horizontalAlignment: Icon.AlignHCenter
			    visible: (label == "" && !panel.hideKeyLabels)
			    height: actionKeyRoot.fontSize
			    width: height
			}
		}
	    }
	}

	FlickPop {
	    anchors.horizontalCenter: buttonRect.horizontalCenter
	    anchors.bottom: buttonRect.top
	    anchors.bottomMargin: key.height * 0.5
	    width: units.gu((UI.fontSize + UI.flickMargin) * 3)
	    height: units.gu((UI.fontSize + UI.flickMargin) * 3)
	    chars: leaves
	    index: keyFlickArea.index
	    visible:(maliit_input_method.enableMagnifier)? key.currentlyPressed && chars.length > 1:false
	}
    }

    // make sure the icon changes even if the property icon* change on runtime
    state: panel.activeKeypadState
    states: [
        State {
            name: "caps"
            PropertyChanges {
                target: iconImage
                source: iconSourceShifted !== "" ? iconSourceShifted 
                                                 : iconShifted ? "image://theme/%1".arg(iconShifted)
                                                               : ""
                color: actionKeyRoot.colorShifted
            }
        },
        State {
            name: "CAPSLOCK"
            PropertyChanges {
                target: iconImage
                source: iconSourceCapsLock !== "" ? iconSourceCapsLock
                                                  : iconCapsLock ? "image://theme/%1".arg(iconCapsLock)
                                                                : ""
                color: actionKeyRoot.colorCapsLock
            }
        }
    ]
}
