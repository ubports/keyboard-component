/*
 * Copyright 2021 UBports Foundation
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

MouseArea {
    id: barActionButton

    property alias iconName: icon.name
    property color iconColor: fullScreenItem.theme.fontColor
    property int iconRotation: 0

    Rectangle {
        anchors.fill: parent
        color: barActionButton.pressed ? fullScreenItem.theme.charKeyPressedColor : fullScreenItem.theme.backgroundColor

        Behavior on color {
            ColorAnimation { duration: UbuntuAnimation.FastDuration; easing: UbuntuAnimation.StandardEasing; }
        }

        Icon {
            id: icon

            implicitWidth: barActionButton.width * 0.60
            implicitHeight: implicitWidth
            anchors.centerIn: parent
            color: iconColor
            transform: Rotation {
				angle: iconRotation
				origin.x: icon.width / 2
				origin.y: icon.height / 2
			}
        }
    }
}
