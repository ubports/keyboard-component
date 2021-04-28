/*
 * This file is part of Maliit plugins
 *
 * Copyright (C) 2012 Openismus GmbH
 *
 * Contact: maliit-discuss@lists.maliit.org
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.4
import "constants.js" as Const
import "theme_loader.js" as Theme
import "keys/"
import "keys/key_constants.js" as UI
import Ubuntu.Components 1.3
import QtFeedback 5.0
import QtMultimedia 5.0
import QtQuick.Layouts 1.3

Item {
    id: fullScreenItem
    objectName: "fullScreenItem"

    property bool landscape: width > height
    readonly property bool tablet: landscape ? width >= units.gu(90) : height >= units.gu(90)
    readonly property bool keyboardFloating: state == "FLOATING"
    readonly property bool oneHanded: state == "ONE-HANDED-LEFT" || state == "ONE-HANDED-RIGHT" || state == "FLOATING"
    readonly property bool keyboardLandscape: landscape && !oneHanded

    property bool cursorSwipe: false
    property int prevSwipePositionX
    property int prevSwipePositionY
    property int cursorSwipeDuration: 5000
    property var timerSwipe: swipeTimer
    property var theme: Theme.defaultTheme

    property variant input_method: maliit_input_method
    property variant event_handler: maliit_event_handler

    onXChanged: fullScreenItem.reportKeyboardVisibleRect();
    onYChanged: fullScreenItem.reportKeyboardVisibleRect();
    onWidthChanged: {
        fullScreenItem.reportKeyboardVisibleRect();
        if (fullScreenItem.keyboardFloating) {
            canvas.x = canvas.returnToBoundsX(canvas.x)
        }
    }
    onHeightChanged: {
        fullScreenItem.reportKeyboardVisibleRect();
        if (fullScreenItem.keyboardFloating) {
            canvas.y = canvas.returnToBoundsY(canvas.floatY)
        }
    }

    Component.onCompleted: Theme.load(maliit_input_method.theme)

    onStateChanged: {
        fullScreenItem.reportKeyboardVisibleRect()
        input_method.usageMode = stateToSettings(state)
    }

    states: [
        State {
            name: "FULL"

            PropertyChanges { target: swipeArea; drag.minimumY: canvas.fixedY }
            AnchorChanges {
                target: canvas
                anchors.left: fullScreenItem.left
                anchors.right: fullScreenItem.right
            }
            PropertyChanges { target: canvas; width: fullScreenItem.width; y: canvas.fixedY }

            // Action bar
            PropertyChanges { target: actionBar; visible: false }
            PropertyChanges { target: swipeArea; anchors.rightMargin: 0; anchors.leftMargin: 0 }
            PropertyChanges { target: cursorSwipeArea; anchors.rightMargin: 0; anchors.leftMargin: 0 }

            // Borders
            PropertyChanges { target: keyboardBorder; visible: false }
            PropertyChanges { target: dividerRect; visible: false }
        }
        ,State {
            name: "ONE-HANDED-LEFT"

            PropertyChanges { target: swipeArea; drag.minimumY: canvas.fixedY }
            AnchorChanges {
                target: canvas
                anchors.left: fullScreenItem.left
                anchors.right: undefined
            }
            PropertyChanges { target: canvas; width: canvas.oneHandedWidth; y: canvas.fixedY }

            // Action bar
            PropertyChanges { target: actionBar; visible: true; x: canvas.width - width }
            PropertyChanges { target: swipeArea; anchors.rightMargin: actionBar.width; anchors.leftMargin: 0 }
            PropertyChanges { target: cursorSwipeArea; anchors.rightMargin: actionBar.width; anchors.leftMargin: 0 }

            // Borders
            PropertyChanges { target: keyboardBorder; visible: false }
            PropertyChanges { target: dividerRect; visible: true }
            AnchorChanges { target: dividerRect; anchors.left: canvas.right ; anchors.right: undefined }
        }
        ,State {
            name: "ONE-HANDED-RIGHT"

            PropertyChanges { target: swipeArea; drag.minimumY: canvas.fixedY }
            AnchorChanges {
                target: canvas
                anchors.right: fullScreenItem.right
                anchors.left: undefined
            }
            PropertyChanges { target: canvas; width: canvas.oneHandedWidth; y: canvas.fixedY }

            // Action bar
            PropertyChanges { target: actionBar; visible: true; x: 0 }
            PropertyChanges { target: swipeArea; anchors.rightMargin: 0; anchors.leftMargin: actionBar.width }
            PropertyChanges { target: cursorSwipeArea; anchors.rightMargin: 0; anchors.leftMargin: actionBar.width }

            // Borders
            PropertyChanges { target: keyboardBorder; visible: false }
            PropertyChanges { target: dividerRect; visible: true }
            AnchorChanges { target: dividerRect; anchors.left: undefined ; anchors.right: canvas.left }
        }
        ,State {
            name: "FLOATING"

            PropertyChanges { target: swipeArea; drag.minimumY: canvas.y }
            AnchorChanges {
                target: canvas
                anchors.left: undefined
                anchors.right: undefined
            }
            PropertyChanges { target: canvas; width: canvas.oneHandedWidth; x: canvas.floatInitialX; y: canvas.fixedY; floatY: y }

            // Action bar
            PropertyChanges { target: actionBar; visible: true; x: canvas.positionedToLeft ? canvas.width - width : 0 }
            PropertyChanges { target: swipeArea; anchors.rightMargin: canvas.positionedToLeft ? actionBar.width : 0; anchors.leftMargin: canvas.positionedToLeft ? 0 : actionBar.width }
            PropertyChanges { target: cursorSwipeArea; anchors.rightMargin: canvas.positionedToLeft ? actionBar.width : 0; anchors.leftMargin: canvas.positionedToLeft ? 0 : actionBar.width }

            // Borders
            PropertyChanges { target: keyboardBorder; visible: true }
            PropertyChanges { target: dividerRect; visible: false }
        }
    ]

    // These rectangles are outside canvas so that they can still be drawn even if layer.enabled is true
    Rectangle {
        id: keyboardBorder

        visible: canvas.visible
        border.color: fullScreenItem.theme.popupBorderColor
        border.width: units.gu(UI.keyboardBorderWidth)
        color: "transparent"
        opacity: canvas.opacity
        anchors {
            fill: canvas
            margins: units.gu(-UI.keyboardBorderWidth)
        }
    }

    Rectangle {
        height: units.dp(1)
        color: fullScreenItem.theme.dividerColor
        anchors {
            bottom: canvas.top
            left: canvas.left
            right: canvas.right
        }
        opacity: canvas.opacity
        visible: canvas.visible
    }

    Rectangle {
        id: dividerRect

        width: units.dp(1)
        color: fullScreenItem.theme.dividerColor
        opacity: canvas.opacity
        visible: canvas.visible
        anchors {
            left: canvas.left
            top: canvas.top
            bottom: canvas.bottom
        }
    }

    transitions: Transition {
        AnchorAnimation { targets: canvas; duration: UbuntuAnimation.FastDuration; easing: UbuntuAnimation.StandardEasing }
    }

    Item {
        id: canvas
        objectName: "ubuntuKeyboard" // Allow us to specify a specific keyboard within autopilot.

        readonly property real oneHandedWidth: Math.min(fullScreenItem.width
                                        * (fullScreenItem.tablet ? fullScreenItem.landscape ? UI.tabletOneHandedPreferredWidthLandscape : UI.tabletOneHandedPreferredWidthPortrait
                                                        : fullScreenItem.landscape ? UI.phoneOneHandedPreferredWidthLandscape : UI.phoneOneHandedPreferredWidthPortrait)
                                        , fullScreenItem.tablet ? units.gu(UI.tabletOneHandedMaxWidth) : units.gu(UI.phoneOneHandedMaxWidth))
        readonly property real fixedY: fullScreenItem.height - height
        readonly property bool positionedToLeft: dragButton.pressed ? positionedToLeft : x + (width / 2) < (fullScreenItem.width / 2)
        property real floatY: y
        property real floatInitialX: (fullScreenItem.width / 2) - (canvas.width / 2)

        // Initially anchor to bottom to avoid the keyboard jumping into place on first show
        anchors.bottom: parent.bottom

        x: 0
        y: fixedY
        width: fullScreenItem.width
        height: (fullScreenItem.oneHanded ? canvas.oneHandedWidth * UI.oneHandedHeight 
                            : fullScreenItem.height * (fullScreenItem.landscape ? fullScreenItem.tablet ? UI.tabletKeyboardHeightLandscape 
                                                                                                                          : UI.phoneKeyboardHeightLandscape
                                                                                            : fullScreenItem.tablet ? UI.tabletKeyboardHeightPortrait 
                                                                                                                          : UI.phoneKeyboardHeightPortrait))
                                      + wordRibbon.height + borderTop.height

        property int keypadHeight: height;

        visible: true

        property bool wordribbon_visible: maliit_word_engine.enabled
        onWordribbon_visibleChanged: fullScreenItem.reportKeyboardVisibleRect();

        property bool languageMenuShown: false
        property bool extendedKeysShown: false

        property bool firstShow: true
        property bool hidingComplete: false

        property string layoutId: "freetext"

        onXChanged: fullScreenItem.reportKeyboardVisibleRect();
        onYChanged: fullScreenItem.reportKeyboardVisibleRect();
        onWidthChanged: {
            fullScreenItem.reportKeyboardVisibleRect();
            if (fullScreenItem.keyboardFloating) {
                canvas.x = canvas.returnToBoundsX(canvas.x)
            }
        }
        onHeightChanged: {
            fullScreenItem.reportKeyboardVisibleRect();
            if (fullScreenItem.keyboardFloating) {
                canvas.y = canvas.returnToBoundsY(canvas.floatY)
            }
        }

        opacity: fullScreenItem.keyboardFloating && dragButton.pressed && maliit_input_method.opacity == 1 ? 0.5 : maliit_input_method.opacity
        layer.enabled: dragButton.pressed

        function returnToBoundsX(baseX) {
            var correctedX = baseX
            if (baseX + canvas.width > fullScreenItem.width) {
                correctedX = fullScreenItem.width - canvas.oneHandedWidth
            }
            return correctedX
        }

        function returnToBoundsY(baseY) {
            var correctedY = baseY
            if (baseY + canvas.height > fullScreenItem.height) {
                correctedY = fullScreenItem.height - canvas.height
            }
            return correctedY
        }

        Rectangle {
            id: background

            anchors.fill: parent
            color: fullScreenItem.theme.backgroundColor
        }

        Rectangle {
            id: actionBar

            color: fullScreenItem.theme.backgroundColor
            width: units.gu(UI.actionBarWidth)
            z: 2

            // Anchor is not used due to issues with dynamic anchor changes
            x: 0
            visible: false
            anchors {
                top: parent.top
                bottom: parent.bottom
            }

            ColumnLayout {
                anchors.fill: parent

                BarActionButton {
                    id: dragButton

                    readonly property bool dragActive: drag.active

                    Layout.fillWidth: true
                    Layout.preferredHeight: width
                    Layout.alignment: Qt.AlignTop
                    iconName: "grip-large"

                    drag.target: canvas
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: fullScreenItem.width - canvas.width
                    drag.minimumY: 0
                    drag.maximumY: fullScreenItem.height - canvas.height

                    onDragActiveChanged: {
                        if (!dragActive) {
                            canvas.floatY = canvas.y
                        }
                    }

                    onPressed: {
                        if (!dragActive && !fullScreenItem.keyboardFloating) {
                            canvas.floatInitialX = canvas.x
                            fullScreenItem.state = "FLOATING"
                        }
                    }
                }

                BarActionButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: width
                    iconName: "go-last"
                    visible: fullScreenItem.state == "ONE-HANDED-LEFT" || (fullScreenItem.keyboardFloating && canvas.x + canvas.width !== fullScreenItem.width)

                    onClicked: {
                        if (fullScreenItem.keyboardFloating) {
                            canvas.x = fullScreenItem.width - canvas.width
                        } else {
                            fullScreenItem.state = "ONE-HANDED-RIGHT"
                        }
                    }
                }

                BarActionButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: width
                    iconName: "go-first"
                    visible: fullScreenItem.state == "ONE-HANDED-RIGHT" || (fullScreenItem.keyboardFloating && canvas.x !== 0)

                    onClicked: {
                        if (fullScreenItem.keyboardFloating) {
                            canvas.x = 0
                        } else {
                            fullScreenItem.state = "ONE-HANDED-LEFT"
                        }
                    }
                }

                BarActionButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: width
                    iconName: "go-last"
                    iconRotation: 90
                    visible: fullScreenItem.keyboardFloating && canvas.y + canvas.height < fullScreenItem.height

                    onClicked: {
                        yAnimation.startAnimation(canvas.fixedY)
                        canvas.floatY = canvas.fixedY
                    }
                }

                BarActionButton {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignBottom
                    Layout.preferredHeight: width * 1.2
                    iconName: "view-fullscreen"
                    visible: fullScreenItem.state !== "FULL"

                    onClicked: {
                        fullScreenItem.state = "FULL"
                    }
                }
            }
        }

        MouseArea {
            id: swipeArea

            property int jumpBackThreshold: units.gu(10)

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: (parent.height - canvas.keypadHeight) + wordRibbon.height +
                    borderTop.height

            drag.target: canvas
            drag.axis: Drag.YAxis;
            drag.minimumY: canvas.fixedY
            drag.maximumY: fullScreenItem.height
            //fix for lp:1277186
            //only filter children when wordRibbon visible
            drag.filterChildren: wordRibbon.visible
            // Avoid conflict with extended key swipe selection and cursor swipe mode
            enabled: !canvas.extendedKeysShown && !fullScreenItem.cursorSwipe

            onReleased: {
                var baseY = fullScreenItem.keyboardFloating ? canvas.floatY : canvas.fixedY
                if (canvas.y > baseY + jumpBackThreshold) {
                    maliit_geometry.shown = false;
                } else {
                    bounceBackAnimation.from = canvas.y
                    bounceBackAnimation.start();
                }
            }

            Behavior on anchors.rightMargin {
                UbuntuNumberAnimation { duration: UbuntuAnimation.SnapDuration}
            }

            Behavior on anchors.leftMargin {
                UbuntuNumberAnimation { duration: UbuntuAnimation.SnapDuration}
            }

            Item {
                id: keyboardSurface
                objectName: "keyboardSurface"

                height: canvas.height
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Rectangle {
                    width: parent.width
                    height: units.dp(1)
                    color: fullScreenItem.theme.dividerColor
                    anchors.bottom: wordRibbon.visible ? wordRibbon.top : keyboardComp.top
                }

                WordRibbon {
                    id: wordRibbon
                    objectName: "wordRibbon"

                    visible: canvas.wordribbon_visible

                    anchors.bottom: keyboardComp.top
                    width: parent.width;

                    height: canvas.wordribbon_visible ? (fullScreenItem.tablet ? units.gu(UI.tabletWordribbonHeight)
                                                                               : units.gu(UI.phoneWordribbonHeight))
                                                      : 0
                    onHeightChanged: fullScreenItem.reportKeyboardVisibleRect();
                }
                //TODO: Sets the theme for all UITK components used in the OSK. Replace those components to remove the need for this.
                ActionItem {
                    id: dummy
                    
                    visible: false
                    theme.name: fullScreenItem.theme.toolkitTheme
                }                
                
                ActionsToolbar {
                    id: toolbar
                    objectName: "actionsToolbar"
                    
                    z: 1
                    visible: fullScreenItem.cursorSwipe
                    height: fullScreenItem.tablet ? units.gu(UI.tabletWordribbonHeight) : units.gu(UI.phoneWordribbonHeight)
                    state: wordRibbon.visible ? "wordribbon" : "top"
                }
                    

                Item {
                    id: keyboardComp
                    objectName: "keyboardComp"

                    height: canvas.keypadHeight - wordRibbon.height + keypad.anchors.topMargin
                    width: parent.width
                    anchors.bottom: parent.bottom

                    onHeightChanged: fullScreenItem.reportKeyboardVisibleRect();

                    Item {
                        id: borderTop
                        width: parent.width
                        anchors.top: parent.top.bottom
                        height: wordRibbon.visible ? 0 : units.gu(UI.top_margin)
                    }

                    KeyboardContainer {
                        id: keypad

                        anchors.top: borderTop.bottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: units.gu(UI.bottom_margin)
                        width: parent.width
                        hideKeyLabels: fullScreenItem.cursorSwipe

                        onPopoverEnabledChanged: fullScreenItem.reportKeyboardVisibleRect();
                    }

                    LanguageMenu {
                        id: languageMenu
                        objectName: "languageMenu"
                        anchors.centerIn: parent
                        height: contentHeight > keypad.height ? keypad.height : contentHeight
                        width: units.gu(30);
                        enabled: canvas.languageMenuShown
                        visible: canvas.languageMenuShown
                    }
                } // keyboardComp
            }
        }

        PropertyAnimation {
            id: bounceBackAnimation
            target: canvas
            properties: "y"
            easing.type: Easing.OutBounce;
            easing.overshoot: 2.0
            to: fullScreenItem.keyboardFloating ? canvas.floatY : canvas.fixedY
        }

        state: "HIDDEN"

        states: [
            State {
                name: "SHOWN"
                PropertyChanges { target: canvas; y: fullScreenItem.keyboardFloating ? canvas.returnToBoundsY(canvas.floatY) : canvas.fixedY; }
                onCompleted: {
                    // Initialize state and visibility on first show
                    if (canvas.firstShow) {
                        fullScreenItem.state = fullScreenItem.settingsToState(input_method.usageMode)
                        canvas.anchors.bottom = undefined;
                        canvas.firstShow = false;
                    }
                    canvas.hidingComplete = false;
                }
                when: maliit_geometry.shown === true
            },

            State {
                name: "HIDDEN"
                PropertyChanges { target: canvas; y: fullScreenItem.height }
                onCompleted: {
                    canvas.languageMenuShown = false;
                    keypad.closeExtendedKeys();
                    keypad.activeKeypadState = "NORMAL";
                    keypad.state = "CHARACTERS";
                    maliit_input_method.close();
                    canvas.hidingComplete = true;
                    reportKeyboardVisibleRect();
                    // Switch back to the previous layout if we're in
                    // in a layout like emoji that requests switchBack
                    if (keypad.switchBack && maliit_input_method.previousLanguage) {
                        keypad.switchBack = false;
                        maliit_input_method.activeLanguage = maliit_input_method.previousLanguage;
                    }
                    
                    // Exit cursor swipe mode when the keyboard hides
                    fullScreenItem.exitSwipeMode();
                }
                // Wait for the first show operation to complete before
                // allowing hiding, as the conditions when the keyboard
                // has never been visible can trigger a hide operation
                when: maliit_geometry.shown === false && canvas.firstShow === false
            }
        ]
        transitions: Transition {
            UbuntuNumberAnimation { target: canvas; properties: "y"; }
        }

        Behavior on x {
            UbuntuNumberAnimation {duration: UbuntuAnimation.FastDuration}
        }

        // Use Standlone animation instead of Behavior to avoid conflict with y changes from PressArea
        UbuntuNumberAnimation {
            id: yAnimation
            target: canvas
            duration: UbuntuAnimation.FastDuration
            from: canvas.y
            property: "y"
            
            function startAnimation(toY) {
                to = toY
                start()
            }
        }

        Connections {
            target: input_method
            onActivateAutocaps: {
                if (keypad.state == "CHARACTERS" && keypad.activeKeypadState != "CAPSLOCK" && !cursorSwipe) {
                    keypad.activeKeypadState = "SHIFTED";
                    keypad.autoCapsTriggered = true;
                } else {
                    keypad.delayedAutoCaps = true;
                }
            }

            onKeyboardReset: {
                keypad.state = "CHARACTERS"
            }
            onDeactivateAutocaps: {
                if(keypad.autoCapsTriggered) {
                    keypad.activeKeypadState = "NORMAL";
                    keypad.autoCapsTriggered = false;
                }
                keypad.delayedAutoCaps = false;
            }
            onThemeChanged: Theme.load(target.theme)

            onUsageModeChanged: {
                fullScreenItem.state = fullScreenItem.settingsToState(target.usageMode)
            }
        }
        
        FloatingActions {
            id: floatingActions
            objectName: "floatingActions"
            
            z: 1
            visible: fullScreenItem.cursorSwipe && !cursorSwipeArea.pressed && !bottomSwipe.pressed
            anchors {
                left: cursorSwipeArea.left
                right: cursorSwipeArea.right
            }
        }

        MouseArea {
            id: cursorSwipeArea

            property point lastRelease
            property bool selectionMode: false
            
            anchors {
                fill: parent
                topMargin: toolbar.height
            }
            
            enabled: cursorSwipe

            Rectangle {
                anchors.fill: parent
                visible: parent.enabled
                color: cursorSwipeArea.selectionMode ? fullScreenItem.theme.selectionColor : fullScreenItem.theme.charKeyPressedColor
                
                Label {
                    visible: !cursorSwipeArea.pressed && !bottomSwipe.pressed
                    horizontalAlignment: Text.AlignHCenter
                    color: cursorSwipeArea.selectionMode ? UbuntuColors.porcelain : fullScreenItem.theme.fontColor
                    wrapMode: Text.WordWrap
                    
                    anchors {
                        left: parent.left
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                    
                    text: cursorSwipeArea.selectionMode ? i18n.tr("Swipe to move selection") + "\n\n" + i18n.tr("Double-tap to exit selection mode")
                                : i18n.tr("Swipe to move cursor") + "\n\n" + i18n.tr("Double-tap to enter selection mode")
                }
            }
            
            function exitSelectionMode() {
                selectionMode = false
                fullScreenItem.timerSwipe.restart()
            }
            
            onSelectionModeChanged: {
                if (fullScreenItem.cursorSwipe) {
                    fullScreenItem.keyFeedback();
                }
            }
            
            onMouseXChanged: {
                processSwipe(mouseX, mouseY)
            }

            onPressed: {
                prevSwipePositionX = mouseX
                prevSwipePositionY = mouseY
                fullScreenItem.timerSwipe.stop()
            }

            onReleased: {
                if (!cursorSwipeArea.selectionMode) {
                    fullScreenItem.timerSwipe.restart()
                } else {
                    fullScreenItem.timerSwipe.stop()
                    
                    // TODO: Disabled word selection until input_method.hasSelection is fixed in QtWebEngine
                    // ubports/ubuntu-touch#1157 <https://github.com/ubports/ubuntu-touch/issues/1157>
                    /*
                    if(!input_method.hasSelection){
                        fullScreenItem.selectWord()
                        cursorSwipeArea.selectionMode = false
                        fullScreenItem.timerSwipe.restart()
                    }
                    */
                }

                lastRelease = Qt.point(mouse.x, mouse.y)
            }
            
            onDoubleClicked: {
                // We avoid triggering double click accidentally by using a threshold
                var xReleaseDiff = Math.abs(lastRelease.x - mouse.x)
                var yReleaseDiff = Math.abs(lastRelease.y - mouse.y)

                var threshold = units.gu(2)

                if (xReleaseDiff < threshold && yReleaseDiff < threshold) {
                    if (!cursorSwipeArea.selectionMode) {
                        cursorSwipeArea.selectionMode = true
                        fullScreenItem.timerSwipe.stop()
                    } else {
                        exitSelectionMode();
                    }
                }
            }
        }

        SwipeArea {
            id: leftSwipe

            height: units.gu(1.5)
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            direction: SwipeArea.Leftwards
            immediateRecognition: false
            grabGesture: false
            visible: (fullScreenItem.state !== "ONE-HANDED-LEFT" || fullScreenItem.keyboardFloating) && !fullScreenItem.cursorSwipe

            onDraggingChanged: {
                if (dragging) {
                    switch (fullScreenItem.state) {
                        case "ONE-HANDED-RIGHT":
                            fullScreenItem.state = "FULL"
                            break
                        case "FULL":
                            fullScreenItem.state = "ONE-HANDED-LEFT"
                            break
                        case "FLOATING":
                            canvas.x = 0
                            break
                    }
                }
            }
        }

        SwipeArea {
            id: rightSwipe

            height: units.gu(1.5)
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            direction: SwipeArea.Rightwards
            immediateRecognition: false
            grabGesture: false
            visible: (fullScreenItem.state !== "ONE-HANDED-RIGHT" || fullScreenItem.keyboardFloating) && !fullScreenItem.cursorSwipe

            onDraggingChanged: {
                if (dragging) {
                    switch (fullScreenItem.state) {
                        case "ONE-HANDED-LEFT":
                            fullScreenItem.state = "FULL"
                            break
                        case "FULL":
                            fullScreenItem.state = "ONE-HANDED-RIGHT"
                            break
                        case "FLOATING":
                            canvas.x = fullScreenItem.width - canvas.width
                            break
                    }
                }
            }
        }

        SwipeArea{
            id: bottomSwipe
            
            property bool draggingCustom: distance >= units.gu(4)
            property bool readyToSwipe: false

            height: units.gu(1.5)
            anchors{
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            direction: SwipeArea.Upwards
            immediateRecognition: true
            grabGesture: false

            onDraggingCustomChanged:{
                if (dragging && !fullScreenItem.cursorSwipe) {
                    readyToSwipe = false
                    swipeDelay.restart()
                    fullScreenItem.cursorSwipe = true
                }
            }

            onTouchPositionChanged: {
                if (fullScreenItem.cursorSwipe && readyToSwipe) {
                    fullScreenItem.processSwipe(touchPosition.x, touchPosition.y)
                }
            }

            onPressedChanged: {
                if (!pressed) {
                    fullScreenItem.timerSwipe.restart()
                }else{
                    fullScreenItem.timerSwipe.stop()
                }
            }
            
            Timer {
                id: swipeDelay
                interval: 100
                running: false
                onTriggered: {
                    fullScreenItem.prevSwipePositionX = bottomSwipe.touchPosition.x
                    fullScreenItem.prevSwipePositionY = bottomSwipe.touchPosition.y
                    bottomSwipe.readyToSwipe = true
                }
            }
        }

        Icon {
            id: bottomHint
            name: "toolkit_bottom-edge-hint"
            visible: !fullScreenItem.cursorSwipe
            width: units.gu(3)
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
        }

    } // canvas

    Timer {
        id: swipeTimer
        interval: cursorSwipeDuration
        running: false
        onTriggered: {
            fullScreenItem.exitSwipeMode();
        }
    }
    
    onCursorSwipeChanged:{
        if (cursorSwipe && input_method.hasSelection) {
            cursorSwipeArea.selectionMode = true
        }
        
        fullScreenItem.keyFeedback();
    }
    
    SoundEffect {
        id: audioFeedback
        source: maliit_input_method.audioFeedbackSound
    }
    
    HapticsEffect {
        id: pressEffect
        attackIntensity: 0.0
        attackTime: 50
        intensity: 1.0
        duration: 10
        fadeTime: 50
        fadeIntensity: 0.0
    }
    
    Connections {
        target: maliit_input_method
        onAudioFeedbackSoundChanged: audioFeedback.source = sound;
    }

    function stateToSettings(_state) {
        var _usageMode

        switch (_state) {
            case "FULL":
                _usageMode = "Full"
                break
            case "ONE-HANDED-LEFT":
                _usageMode = "One-handed-left"
                break
            case "ONE-HANDED-RIGHT":
                _usageMode = "One-handed-right"
                break
            case "FLOATING":
                _usageMode = "Floating"
                break
            default:
                _usageMode = "Full"
                break
        }

        return _usageMode
    }

    function settingsToState(_usageMode) {
        var _state

        switch (_usageMode) {
            case "Full":
                _state = "FULL"
                break
            case "One-handed-left":
                _state = "ONE-HANDED-LEFT"
                break
            case "One-handed-right":
                _state = "ONE-HANDED-RIGHT"
                break
            case "Floating":
                _state = "FLOATING"
                break
            default:
                _state = "FULL"
                break
        }

        return _state
    }

    function keyFeedback() {
        if (maliit_input_method.useHapticFeedback) {
            pressEffect.start()
        }
        
        if (maliit_input_method.useAudioFeedback) {
            audioFeedback.play()
        }
    }
    
    function exitSwipeMode() {
        fullScreenItem.cursorSwipe = false
        fullScreenItem.timerSwipe.stop()
        cursorSwipeArea.selectionMode = false
        
        // We only enable autocaps after cursor movement has stopped
        if (keypad.delayedAutoCaps) {
            keypad.activeKeypadState = "SHIFTED"
            keypad.delayedAutoCaps = false
        } else {
            keypad.activeKeypadState = "NORMAL"
        }
    }

    function reportKeyboardVisibleRect() {

        var vx = canvas.x;
        var vy = canvas.y;
        var vwidth = canvas.width;
        var vheight = canvas.height;

        var obj = Qt.rect(vx, vy, vwidth, vheight);
        // Report visible height of the keyboard to support anchorToKeyboard
        if (!fullScreenItem.keyboardFloating) {
            obj.height = fullScreenItem.height - obj.y;
        }

        // Work around QT bug: https://bugreports.qt-project.org/browse/QTBUG-20435
        // which results in a 0 height being reported incorrectly immediately prior
        // to the keyboard closing animation starting, which causes us to report
        // an extra visibility change for the keyboard.
        if (obj.height <= 0 && !canvas.hidingComplete) {
            return;
        }

        maliit_geometry.visibleRect = Qt.rect(obj.x, obj.y, obj.width, obj.height);
    }

    // Autopilot needs to be able to move the cursor even when the layout
    // doesn't provide arrow keys (e.g. in phone mode)
    function sendLeftKey() {
        event_handler.onKeyReleased("", "left");
    }
    function sendRightKey() {
        event_handler.onKeyReleased("", "right");
    }
    function sendUpKey() {
        event_handler.onKeyReleased("", "up");
    }
    function sendDownKey() {
        event_handler.onKeyReleased("", "down");
    }
    function sendHomeKey() {
        event_handler.onKeyReleased("", "home");
    }
    function sendEndKey() {
        event_handler.onKeyReleased("", "end");
    }
    function selectLeft() {
        event_handler.onKeyReleased("SelectPreviousChar", "keysequence");
    }
    function selectRight() {
        event_handler.onKeyReleased("SelectNextChar", "keysequence");
    }
    function selectUp() {
        event_handler.onKeyReleased("SelectPreviousLine", "keysequence");
    }
    function selectDown() {
        event_handler.onKeyReleased("SelectNextLine", "keysequence");
    }
    function selectWord() {
        event_handler.onKeyReleased("MoveToPreviousWord", "keysequence");
        event_handler.onKeyReleased("SelectNextWord", "keysequence");
    }
    function selectStartOfLine() {
        event_handler.onKeyReleased("SelectStartOfLine", "keysequence");
    }
    function selectEndOfLine() {
        event_handler.onKeyReleased("SelectEndOfLine", "keysequence");
    }
    function selectStartOfDocument() {
        event_handler.onKeyReleased("SelectStartOfDocument", "keysequence");
    }
    function selectEndOfDocument() {
        event_handler.onKeyReleased("SelectEndOfDocument", "keysequence");
    }
    function selectAll() {
        event_handler.onKeyReleased("SelectAll", "keysequence");
    }
    function moveToStartOfLine() {
        event_handler.onKeyReleased("MoveToStartOfLine", "keysequence");
    }
    function moveToEndOfLine() {
        event_handler.onKeyReleased("MoveToEndOfLine", "keysequence");
    }
    function moveToStartOfDocument() {
        event_handler.onKeyReleased("MoveToStartOfDocument", "keysequence");
    }
    function moveToEndOfDocument() {
        event_handler.onKeyReleased("MoveToEndOfDocument", "keysequence");
    }
    function redo() {
        event_handler.onKeyReleased("Redo", "keysequence");
    }
    function undo() {
        event_handler.onKeyReleased("Undo", "keysequence");
    }
    function paste() {
        event_handler.onKeyReleased("Paste", "keysequence");
    }
    function copy() {
        event_handler.onKeyReleased("Copy", "keysequence");
    }
    function cut() {
        event_handler.onKeyReleased("Cut", "keysequence");
    }

    function processSwipe(positionX, positionY) {
        // TODO: Removed input_method.surrounding* from the criteria until they are fixed in QtWebEngine
        // ubports/ubuntu-touch#1157 <https://github.com/ubports/ubuntu-touch/issues/1157>
        if (positionX < prevSwipePositionX - units.gu(1) /*&& input_method.surroundingLeft != ""*/) {
            if(cursorSwipeArea.selectionMode){
                selectLeft();
            }else{
                sendLeftKey();
            }
            prevSwipePositionX = positionX
        } else if (positionX > prevSwipePositionX + units.gu(1) /*&& input_method.surroundingRight != ""*/) {
            if(cursorSwipeArea.selectionMode){
                selectRight();
            }else{
                sendRightKey();
            }
            prevSwipePositionX = positionX
        } 

        if (positionY < prevSwipePositionY - units.gu(4)) {
            if(cursorSwipeArea.selectionMode){
                selectUp();
            }else{
                sendUpKey();
            }
            prevSwipePositionY = positionY
        } else if (positionY > prevSwipePositionY + units.gu(4)) {
            if(cursorSwipeArea.selectionMode){
                selectDown();
            }else{
                sendDownKey();
            }
            prevSwipePositionY = positionY
        }
    }

} // fullScreenItem
