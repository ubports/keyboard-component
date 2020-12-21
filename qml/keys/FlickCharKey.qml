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
import QtQuick.Layouts 1.1

import "key_constants.js" as UI

Item {
    id: key

    property int padding: 0
    width: leftSide || rightSide ? panel.keyWidth * 2 : panel.keyWidth
    height: c1.keyHeight

    /* to be set in keyboard layouts */
    property string label: "";
    property var leaves: ["", "", "", "", ""];
    property var charlabel: ["", "", "", "", ""];
    property var shiftedlabel: ["", "", "", "", ""];
    property var shiftedleaves: ["", "", "", "", ""];
    property int index: keyFlickArea.index;
    property bool highlight: false;

    property string action
    property bool noMagnifier: true
    property bool labelright:false
    property bool labelleft:false
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
    property var iconNormalSource: ["", "", "", "", ""];
    property var iconDisabled: ["", "", "", "", ""];
    property var iconCommon: [
                            iconNormalSource[0] !== "" ? iconNormalSource[0]
                                                       : iconNormal[0] ? "image://theme/%1".arg(iconNormal[0]) : "",
                            iconNormalSource[1] !== "" ? iconNormalSource[1]
                                                       : iconNormal[1] ? "image://theme/%1".arg(iconNormal[1]) : "",
                            iconNormalSource[2] !== "" ? iconNormalSource[2]
                                                       : iconNormal[2] ? "image://theme/%1".arg(iconNormal[2]) : "",
                            iconNormalSource[3] !== "" ? iconNormalSource[3]
                                                       : iconNormal[3] ? "image://theme/%1".arg(iconNormal[3]) : "",
                            iconNormalSource[4] !== "" ? iconNormalSource[4]
                                                       : iconNormal[4] ? "image://theme/%1".arg(iconNormal[4]) : ""
                    ];
    property var iconShifted: ["", "", "", "", ""];
    property var iconCapsLock: ["", "", "", "", ""];
    property var iconCaps: [
                            iconCapsLock[0] ? "image://theme/%1".arg(iconCapsLock[0]) : "",
                            iconCapsLock[1] ? "image://theme/%1".arg(iconCapsLock[1]) : "",
                            iconCapsLock[2] ? "image://theme/%1".arg(iconCapsLock[2]) : "",
                            iconCapsLock[3] ? "image://theme/%1".arg(iconCapsLock[3]) : "",
                            iconCapsLock[4] ? "image://theme/%1".arg(iconCapsLock[4]) : ""
                    ];
    property var iconAutoCaps: [
                            iconShifted[0] ? "image://theme/%1".arg(iconShifted[0]) : "",
                            iconShifted[1] ? "image://theme/%1".arg(iconShifted[1]) : "",
                            iconShifted[2] ? "image://theme/%1".arg(iconShifted[2]) : "",
                            iconShifted[3] ? "image://theme/%1".arg(iconShifted[3]) : "",
                            iconShifted[4] ? "image://theme/%1".arg(iconShifted[4]) : ""
                    ];

    property color colorNormal: fullScreenItem.theme.fontColor
    property color colorShifted: fullScreenItem.theme.fontColor
    property color colorCapsLock: fullScreenItem.theme.fontColor

    property var iconAngles: ["", "", "", "", ""];
    property int leavesFontSize: units.gu(UI.fontSize);

    /* design */
    property string normalColor: fullScreenItem.theme.charKeyColor
    property string pressedColor: fullScreenItem.theme.charKeyPressedColor
    property bool borderEnabled: fullScreenItem.theme.keyBorderEnabled
    property string borderColor: borderEnabled ? fullScreenItem.theme.charKeyBorderColor : "transparent"
    property int fontSize: (fullScreenItem.landscape ? (height / 2) : (height / 2.8));

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
            property int iconSize: !fullScreenItem.landscape ? width/4 : width/6
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
                        source: iconCommon[0]
                        color: fullScreenItem.theme.selectionColor
                        Layout.alignment: Qt.AlignHCenter
                        visible: (iconCommon[0] != "" && !panel.hideKeyLabels)
                        width: buttonRect.iconSize
                        height: buttonRect.iconSize
                        transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[0]}
                    }

                    Text {
                        id: tapLabel
                        text: (panel.activeKeypadState === "NORMAL")?charlabel[0]:shiftedlabel[0]
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: UI.fontFamily
                        font.pixelSize: fontSize
                        font.weight: Font.Light
                        color: fullScreenItem.theme.selectionColor
                        textFormat: Text.StyledText
                        visible:!iconImageLeft.visible && !panel.hideKeyLabels
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
                            source: iconCommon[1]
                            color: key.colorNormal
                            Layout.alignment: Qt.AlignHCenter
                            visible: (iconCommon[1] != "" && !panel.hideKeyLabels)
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[1]}
                    }

                    Icon {
                            id: iconLeft
                            source: iconDisabled[1] != "" ? "image://theme/%1".arg(iconDisabled[1]):""
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            visible: (middleLeftLabel.text == "" && !iconImageLeft.visible && !panel.hideKeyLabels)
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[1]}
                    }

                    Text {
                            id: middleLeftLabel
                            text: (panel.activeKeypadState === "NORMAL")?charlabel[1]:shiftedlabel[1]
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconLeft.visible && !iconImageLeft.visible && !panel.hideKeyLabels
                    }
                }

                ColumnLayout {
                  id: topColumn
                  Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6
                  Layout.alignment : Qt.AlignTop
                  spacing: 0

                  Icon {
                            id: iconImageUp
                            source: iconCommon[2]
                            color: key.colorNormal
                            Layout.alignment: Qt.AlignHCenter

                            visible: (iconCommon[2] != "" && !panel.hideKeyLabels)
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[2]}
                  }

                  Text {
                            id: topCenterLabel
                            text: (panel.activeKeypadState === "NORMAL")?charlabel[2]:shiftedlabel[2];
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconImageUp.visible && !panel.hideKeyLabels
                  }
                }
            }

            RowLayout {
                id: bottomRightCol
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                spacing: 0

                ColumnLayout {
                    id: bottomColumn
                    Layout.minimumWidth: !fullScreenItem.landscape ? buttonRect.width/4 : buttonRect.width/6
                    Layout.alignment : Qt.AlignBottom
                    spacing: 0

                   Icon {
                            id: iconImageDown
                            source: iconCommon[4]
                            color: key.colorNormal
                            Layout.alignment: Qt.AlignHCenter
                            visible: (iconCommon[4] != "" && !panel.hideKeyLabels)
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[4]}
                    }

                    Icon {
                            id: iconDown
                            source: iconDisabled[4] != "" ? "image://theme/%1".arg(iconDisabled[4]):""
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            visible: (bottomCenterLabel.text == "" && !iconImageDown.visible && !panel.hideKeyLabels)
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[4]}
                    }

                    Text {
                            id: bottomCenterLabel
                            text:  (panel.activeKeypadState === "NORMAL")?charlabel[4]:shiftedlabel[4]
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconDown.visible && !iconImageDown.visible && !panel.hideKeyLabels
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
                            source: iconCommon[3]
                            color: key.colorNormal
                            Layout.alignment: Qt.AlignHCenter
                            visible: (iconCommon[3] != "" && !panel.hideKeyLabels)
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[3]}
                    }

                    Icon {
                            id: iconRight
                            source: iconDisabled[3] != "" ? "image://theme/%1".arg(iconDisabled[3]):""
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: buttonRect.iconSize
                            height: buttonRect.iconSize
                            visible: (middleRightLabel.text == "" && !iconImageRight.visible && !panel.hideKeyLabels)
                            transform: Rotation { origin.x:buttonRect.iconSize/2; origin.y:buttonRect.iconSize/2; angle:iconAngles[3]}
                    }

                    Text {
                            id: middleRightLabel
                            text: (panel.activeKeypadState === "NORMAL")?charlabel[3]:shiftedlabel[3]
                            Layout.alignment: Qt.AlignHCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: UI.fontFamily
                            font.pixelSize:fontSize
                            font.weight: Font.Light
                            color: fullScreenItem.theme.fontColor
                            textFormat: Text.StyledText
                            visible: !iconImageRight.visible && !iconRight.visible && !panel.hideKeyLabels
                    }
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
            chars: (panel.activeKeypadState === "NORMAL")?leaves:shiftedleaves
            icons: iconCommon
            angles:iconAngles
            popFontSize: leavesFontSize
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
          event_handler.onKeyReleased(flickPop.chars[index], action);
               if(panel.autoCapsTriggered){
                       panel.autoCapsTriggered=false;
               }else if (!skipAutoCaps) {
                    if (panel.activeKeypadState === "SHIFTED" && panel.state === "CHARACTERS"){
                        panel.activeKeypadState = "NORMAL";
                    }
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

            if(action != "backspace") {
                panel.autoCapsTriggered = false;
            }
            event_handler.onKeyPressed(flickPop.chars[index], action);
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
                    name: "SHIFTED"
                    PropertyChanges {
                        target: flickPop
                        icons: iconAutoCaps
                    }
                    PropertyChanges {
                        target: iconImage
                        source: iconAutoCaps[0]
                    }
                    PropertyChanges {
                        target: iconImageUp
                        source: iconAutoCaps[2]
                    }
                    PropertyChanges {
                        target: iconImageDown
                        source: iconAutoCaps[4]
                    }
                    PropertyChanges {
                        target: iconImageLeft
                        source: iconAutoCaps[1]
                    }
                    PropertyChanges {
                        target: iconImageRight
                        source: iconAutoCaps[3]
                    }
                },
                State {
                    name: "CAPSLOCK"
                    PropertyChanges {
                        target: flickPop
                        icons: iconCaps
                    }
                    PropertyChanges {
                        target: iconImage
                        source: iconCaps[0]
                    }
                    PropertyChanges {
                        target: iconImageUp
                        source: iconCaps[2]
                    }
                    PropertyChanges {
                        target: iconImageDown
                        source: iconCaps[4]
                    }
                    PropertyChanges {
                        target: iconImageLeft
                        source: iconCaps[1]
                    }
                    PropertyChanges {
                        target: iconImageRight
                        source: iconCaps[3]
                    }
                }
            ]
}
