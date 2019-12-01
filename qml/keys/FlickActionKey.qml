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

import QtMultimedia 5.0
import Ubuntu.Components 1.3

import Ubuntu.Components.Popups 1.3
import "key_constants.js" as UI
import QtQuick.Layouts 1.1

FlickCharKey {
    id: actionKeyRoot
    property var iconNormal: ["", "", "", "", ""];
    property var iconShifted: ["", "", "", "", ""];
    property string iconCapsLock: ["", "", "", "", ""];

    property var iconSource: ["", "", "", "", ""];
    property var iconsleaves: ["", "", "", "", ""];
    property string iconSourceCapsLock: ""

    padding: UI.actionKeyPadding
    noMagnifier: true
    skipAutoCaps: true

    height: c1.keyHeight;
    width: panel.keyWidth 

    normalColor: fullScreenItem.theme.charKeyColor
    pressedColor: fullScreenItem.theme.actionKeyPressedColor
    borderColor: fullScreenItem.theme.actionKeyBorderColor

    // can be overwritten by keys
    property color colorNormal: fullScreenItem.theme.fontColor
    property color colorShifted: fullScreenItem.theme.fontColor
    property color colorCapsLock: fullScreenItem.theme.fontColor
    property int fontSize: isPortrait ? buttonRect.width/4 : buttonRect.width/6

    // Make it possible for the visible area of the key to differ from the
    // actual key size. This allows us to extend the touch area of the bottom
    // row of keys all the way to the bottom of the keyboard, whilst
    // maintaining the same visual appearance.
		Item {
			anchors.top: parent.top
			height: parent.height
			width: parent.width

			Rectangle {
			    id: buttonRect
			    color: actionKeyRoot.currentlyPressed || actionKeyRoot.highlight ? pressedColor : normalColor
			    anchors.fill: parent
			    anchors.leftMargin: actionKeyRoot.leftSide ? (parent.width - panel.keyWidth) + actionKeyRoot.keyMargin : actionKeyRoot.keyMargin
			    anchors.rightMargin: actionKeyRoot.rightSide ? (parent.width - panel.keyWidth) + actionKeyRoot.keyMargin : actionKeyRoot.keyMargin
			    anchors.bottomMargin: actionKeyRoot.rowMargin
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
					    source: iconSource[0] !== "" ? iconSource[0]
									    : iconNormal[0] ? "image://theme/%1".arg(iconNormal[0])
											 : ""
					    color: fullScreenItem.theme.selectionColor
					    anchors.horizontalCenter: parent.horizontalCenter
					    //horizontalAlignment: Text.AlignHCenter
					    visible: (charlabel[0] == "" && !panel.hideKeyLabels)
					    height: fontSize
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
					    source: iconSource[1] !== "" ? iconSource[1]
									    : iconNormal[1] ? "image://theme/%1".arg(iconNormal[1])
											 : ""
					    color: actionKeyRoot.colorNormal
					anchors.horizontalCenter: parent.horizontalCenter
					//horizontalAlignment: Text.AlignHCenter
					    visible: (charlabel[1] == "" && !panel.hideKeyLabels)
					    height: fontSize
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
					    source: iconSource[2] !== "" ? iconSource[2]
									    : iconNormal[2] ? "image://theme/%1".arg(iconNormal[2])
											 : ""
					    color: actionKeyRoot.colorNormal
					    anchors.horizontalCenter: parent.horizontalCenter
					    //horizontalAlignment: Text.AlignHCenter

					    visible: (charlabel[2] == "" && !panel.hideKeyLabels)
					    height: fontSize
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
					    source: iconSource[4] !== "" ? iconSource[4]
									    : iconNormal[4] ? "image://theme/%1".arg(iconNormal[4])
											 : ""
					    color: actionKeyRoot.colorNormal
					    anchors.horizontalCenter: parent.horizontalCenter
					    //horizontalAlignment: Text.AlignHCenter
					    anchors.bottom: parent.bottom
					    anchors.bottomMargin: units.gu(0.25)
					    visible: (charlabel[4] == "" && !panel.hideKeyLabels)
					    height: fontSize
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
					    source: iconSource[3] !== "" ? iconSource[3]
									    : iconNormal[3] ? "image://theme/%1".arg(iconNormal[3])
											 : ""
					    color: actionKeyRoot.colorNormal
					    anchors.horizontalCenter: parent.horizontalCenter
					    //horizontalAlignment: Icon.AlignHCenter
					    visible: (charlabel[3] == "" && !panel.hideKeyLabels)
					    height: fontSize
					    width: height
					}
				}
			    }
			}

			FlickPop {
			    anchors.horizontalCenter: buttonRect.horizontalCenter
			    anchors.bottom: buttonRect.top
			    anchors.bottomMargin: actionKeyRoot.height * 0.5
			    width: units.gu((UI.fontSize + UI.flickMargin) * 3)
			    height: units.gu((UI.fontSize + UI.flickMargin) * 3)
			    icons:iconNormal
			    iconSources:iconsleaves
			    index: keyFlickArea.index
			    visible:(maliit_input_method.enableMagnifier)? actionKeyRoot.currentlyPressed && chars.length > 1:false
			}
		    }
	    

    // make sure the icon changes even if the property icon* change on runtime
    state: panel.activeKeypadState
    states: [
        State {
            name: "caps"
            PropertyChanges {
                target: iconImageUp
                source: iconSource[2] !== "" ? iconSource[2] 
                                                 : iconShifted[2] ? "image://theme/%1".arg(iconShifted[2])
                                                               : ""
                color: actionKeyRoot.colorShifted
            }
	    PropertyChanges {
                target: iconImageDown
                source: iconSource[4] !== "" ? iconSource[4] 
                                                 : iconShifted[4] ? "image://theme/%1".arg(iconShifted[4])
                                                               : ""
                color: actionKeyRoot.colorShifted
            }
	    PropertyChanges {
                target: iconImageLeft
                source: iconSource[1] !== "" ? iconSource[1] 
                                                 : iconShifted[1] ? "image://theme/%1".arg(iconShifted[1])
                                                               : ""
                color: actionKeyRoot.colorShifted
            }
	    PropertyChanges {
                target: iconImageRight
                source: iconSource[3] !== "" ? iconSource[3] 
                                                 : iconShifted[3] ? "image://theme/%1".arg(iconShifted[3])
                                                               : ""
                color: actionKeyRoot.colorShifted
            }
        },
        State {
            name: "CAPSLOCK"
            PropertyChanges {
                target: iconImageUp
                source: iconSourceCapsLock !== "" ? iconSourceCapsLock
                                                  : iconCapsLock[2] ? "image://theme/%1".arg(iconCapsLock[2])
                                                                : ""
                color: actionKeyRoot.colorCapsLock
            }
        }
    ]
}
