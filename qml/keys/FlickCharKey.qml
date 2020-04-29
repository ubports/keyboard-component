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
import QtMultimedia 5.0
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "key_constants.js" as UI

Item {
    id: key

    property int padding: 0
 
    width: leftSide || rightSide ? panel.keyWidth * 2 : panel.keyWidth
    height: c1.keyHeight
    
    /* to be set in keyboard layouts */
    property string label: "";
    property var leaves: ["", "", "", "", ""];
    property int index: keyFlickArea.index;
    property bool highlight: false;

    property string action
    property bool noMagnifier: true
    property bool skipAutoCaps: false
    property bool switchBackFromSymbols: false

    property bool leftSide: false
    property bool rightSide: false

    property double rowMargin: fullScreenItem.tablet ? units.gu(UI.tabletRowMargin)
                                                     : (fullScreenItem.landscape ? units.dp(UI.phoneRowMarginLandscape)
                                                                                 : units.dp(UI.phoneRowMarginPortrait))
    property double keyMargin: fullScreenItem.tablet ? units.gu(UI.tabletKeyMargins)
                                                     : units.gu(UI.phoneKeyMargins)

    // These properties are used by autopilot to determine the visible
    // portion of the key to press
    readonly property double leftOffset: buttonRect.anchors.leftMargin
    readonly property double rightOffset: buttonRect.anchors.rightMargin

    /* icons */
    property var iconNormal: ["", "", "", "", ""];
    property var iconShifted: ["", "", "", "", ""];
    property var iconCapsLock: ["", "", "", "", ""];
    property var iconCaps: [
			    "",
			    iconCapsLock[1] ? "image://theme/%1".arg(iconCapsLock[1]) : "",
			    iconCapsLock[2] ? "image://theme/%1".arg(iconCapsLock[2]) : "",
			    iconCapsLock[3] ? "image://theme/%1".arg(iconCapsLock[3]) : "",
			    iconCapsLock[4] ? "image://theme/%1".arg(iconCapsLock[4]) : ""
		    ];
    property var iconAutoCaps: [
			    "",
			    iconShifted[1] ? "image://theme/%1".arg(iconShifted[1]) : "",
			    iconShifted[2] ? "image://theme/%1".arg(iconShifted[2]) : "",
			    iconShifted[3] ? "image://theme/%1".arg(iconShifted[3]) : "",
			    iconShifted[4] ? "image://theme/%1".arg(iconShifted[4]) : ""
		    ];

    property color colorNormal: fullScreenItem.theme.fontColor
    property color colorShifted: fullScreenItem.theme.fontColor
    property color colorCapsLock: fullScreenItem.theme.fontColor

    property var iconAngles: ["", "", "", "", ""];

    /* design */
    property string normalColor: fullScreenItem.theme.charKeyColor
    property string pressedColor: fullScreenItem.theme.charKeyPressedColor
    property bool borderEnabled: fullScreenItem.theme.keyBorderEnabled
    property string borderColor: borderEnabled ? fullScreenItem.theme.charKeyBorderColor : "transparent"
    property int fontSize: (fullScreenItem.landscape ? (height / 2) : (height / 2.8));
    property int iconSize: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6

    /// annotation shows a small label in the upper right corner
    // if the annotiation property is set, it will be used. If not, the first position in extended[] list or extendedShifted[] list will
    // be used, depending on the state. If no extended/extendedShifted arrays exist, no annotation is shown
    property string annotation: ""

    /*! indicates if te key is currently pressed/down*/
    property alias currentlyPressed: keyFlickArea.pressed

    property string oskState: panel.activeKeypadState

    // Allow action keys to override the standard key behaviour
    property bool overridePressArea: false

    signal pressed()
    signal released()

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
            Column {
                spacing: units.gu( UI.annotationsMargins )
                anchors.centerIn: parent
                Text {
                    id: keyLabel
                    text: (panel.hideKeyLabels)?"":label
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: UI.fontFamily
                    font.pixelSize: fontSize
                    font.weight: Font.Light
                    color: fullScreenItem.theme.fontColor
                    textFormat: Text.StyledText
                    visible: label!=""
                }
                Text{
                     id: annotationLabel
                     text: (panel.hideKeyLabels)?"":annotation
                     anchors.horizontalCenter: parent.horizontalCenter
                     anchors.bottomMargin: units.gu( UI.annotationMargins )
                     font.family: UI.fontFamily
                     font.pixelSize:  fullScreenItem.tablet ? units.dp(UI.tabletAnnotationFontSize) : units.dp(UI.phoneAnnotationFontSize)
                     font.weight: Font.Light
                     color: fullScreenItem.theme.fontColor
                     textFormat: Text.StyledText
                     visible: annotation != ""
                }
            }

            RowLayout {
                id: tapLeftTopCol
                anchors.left: parent.left
                spacing: 0

                ColumnLayout {
                    id: tapColumn
                    Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/3
                    Layout.alignment : Qt.AlignTop
                    spacing: 0

                     Icon {
                        id: iconImage
                        source: iconNormal[0] ? "image://theme/%1".arg(iconNormal[0])
                                     : ""
                        color: fullScreenItem.theme.selectionColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: (iconNormal[0] != "" && !panel.hideKeyLabels)
                        width: iconSize
                        height: iconSize
                        transform: Rotation { origin.x:iconSize/2; origin.y:iconSize/2; angle:iconAngles[0]}
                    }

                    Text {
                        id: tapLabel
                        text: (panel.hideKeyLabels)?"":charlabel[0]
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: UI.fontFamily
                        font.pixelSize: fontSize
                        font.weight: Font.Light
                        color: fullScreenItem.theme.selectionColor
                        textFormat: Text.StyledText
                        visible: !iconImage.visible
                    }
                }

                ColumnLayout {
                    id: leftColumn
                    Layout.alignment: Qt.AlignVCenter
                    Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6
                    Layout.preferredHeight: buttonRect.height
                    spacing: 0

                    Icon {
                            id: iconImageLeft
                            source: iconNormal[1] ? "image://theme/%1".arg(iconNormal[1])
                                                                         : ""
                            color: key.colorNormal
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: (iconNormal[1] != "" && !panel.hideKeyLabels)
                            width: iconSize
                            height: iconSize
                            transform: Rotation { origin.x:iconSize/2; origin.y:iconSize/2; angle:iconAngles[1]}
                    }

                    Text {
                            id: middleLeftLabel
                            text: (panel.hideKeyLabels)?"":charlabel[1]
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconImageLeft.visible
                    }
                }
            }

                ColumnLayout {
                  id: topColumn
                  Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6
                  Layout.alignment : Qt.AlignTop
                  spacing: 0

                  Icon {
                            id: iconImageUp
                            source: iconNormal[2] ? "image://theme/%1".arg(iconNormal[2])
									 : ""
                            color: key.colorNormal
                            anchors.horizontalCenter: parent.horizontalCenter

                            visible: (iconNormal[2] != "" && !panel.hideKeyLabels)
                            width: iconSize
                            height: iconSize
                            transform: Rotation { origin.x:iconSize/2; origin.y:iconSize/2; angle:iconAngles[2]}
                  }

                  Text {
                            id: topCenterLabel
                            text: (panel.hideKeyLabels)?"":charlabel[2]
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconImageUp.visible
                  }
                  Text {
                      id: keyLabel
                      text: (panel.hideKeyLabels)?"":label
                      anchors.horizontalCenter: parent.horizontalCenter
                      font.family: UI.fontFamily
                      font.pixelSize: fontSize
		      font.weight: Font.Light
                      color: fullScreenItem.theme.fontColor
                      textFormat: Text.StyledText
                      visible: label!=""
                   }
                }
            }

            RowLayout {
                id: bottomRightCol
                anchors.right: parent.right
                spacing: 0

                ColumnLayout {
                    id: bottomColumn
                    Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6
                    Layout.alignment : Qt.AlignBottom
                    spacing: 0

                   Icon {
                            id: iconImageDown
                            source: iconNormal[4] ? "image://theme/%1".arg(iconNormal[4])
                                    : ""
                            color: key.colorNormal
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: units.gu(0.25)
                            visible: (iconNormal[4] != "" && !panel.hideKeyLabels)
                            width: iconSize
                            height: iconSize
                            transform: Rotation { origin.x:iconSize/2; origin.y:iconSize/2; angle:iconAngles[4]}
                    }

                    Text {
                            id: bottomCenterLabel
                            text:  (panel.hideKeyLabels)?"":charlabel[4]
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: units.gu(0.25)
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconImageDown.visible
                    }
                }

                ColumnLayout {
                    id: rightColumn
                    Layout.alignment: Qt.AlignVCenter
                    Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6
                    Layout.preferredHeight: buttonRect.height
                    spacing: 0

                    Icon {
                            id: iconImageRight
                            source: iconNormal[3] ? "image://theme/%1".arg(iconNormal[3])
									 : ""
                            color: key.colorNormal
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: (iconNormal[3] != "" && !panel.hideKeyLabels)
                            width: iconSize
                            height: iconSize
                            transform: Rotation { origin.x:iconSize/2; origin.y:iconSize/2; angle:iconAngles[3]}
                    }

                    Text {
                            id: middleRightLabel
                            text: (panel.hideKeyLabels)?"":charlabel[3]
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconImageRight.visible
                    }
                }
            }
	    Column {
                spacing: units.gu( UI.annotationMargins )
                anchors.left: parent.left
		 Text {
                    id: tapLabel
                    text: (panel.hideKeyLabels)?"":charlabel[0]
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: UI.fontFamily
                    font.pixelSize: fontSize
		    font.weight: Font.Light
                    color: fullScreenItem.theme.selectionColor
                    textFormat: Text.StyledText
                }

		}

        }

        FlickPop {
            id : flickPop
            anchors.horizontalCenter: buttonRect.horizontalCenter
            anchors.bottom: buttonRect.top
            anchors.bottomMargin: key.height * 0.5
            width: units.gu((UI.fontSize + UI.flickMargin) * 3)
            height: units.gu((UI.fontSize + UI.flickMargin) * 3)
            chars: leaves
            icons:iconNormal
            angles:iconAngles
            index: keyFlickArea.index
            visible:(maliit_input_method.enableMagnifier)? key.currentlyPressed && chars.length > 1:false
        }
    }

    FlickArea {
        id: keyFlickArea
        anchors.fill: key

        onReleased: {
            if (overridePressArea) {
                key.released();
                return;
            }
	   event_handler.onKeyReleased(leaves[index], action);
       if(panel.autoCapsTriggered){
	    		panel.autoCapsTriggered=false;
		}
 
 }

        onPressed: {
            if (overridePressArea) {
                key.pressed();
                return;
            }

            if (maliit_input_method.useAudioFeedback)
                audioFeedback.play();

            if (maliit_input_method.useHapticFeedback)
                pressEffect.start();

            event_handler.onKeyPressed(leaves[index], action);
        }
    }

    Connections {
        target: swipeArea.drag
        onActiveChanged: {
            if (swipeArea.drag.active)
                keyFlickArea.cancelPress();
        }
    }
    // make sure the icon changes even if the property icon* change on runtime

    state: panel.activeKeypadState
    states: [
        State {
            name: "caps"

	    PropertyChanges {
                target: flickPop
		icons: panel.autoCapsTriggered ? iconShifted : iconCapsLock
            }
	    PropertyChanges {
                target: iconImageUp
                source: panel.autoCapsTriggered ? iconAutoCaps[2] : iconCaps[2]
                color: key.colorShifted
            }
	    PropertyChanges {
                target: iconImageDown
                source: panel.autoCapsTriggered ? iconAutoCaps[4] : iconCaps[4]
                color: key.colorShifted
            }
	    PropertyChanges {
                target: iconImageLeft
                source: panel.autoCapsTriggered ? iconAutoCaps[1] : iconCaps[1]
                color: key.colorShifted
            }
	    PropertyChanges {
                target: iconImageRight
                source: panel.autoCapsTriggered ? iconAutoCaps[3] : iconCaps[3]
                color: key.colorShifted
            }
        }
    ]
}
