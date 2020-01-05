import QtQuick 2.13
import QtQuick.Layouts 1.13

import '../components'

Item {
    ColumnLayout {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300

        spacing: 12

        Item {
            Layout.fillHeight: true
        }

        Text {
            id: title

            Layout.fillWidth: true

            text: "telebruh"

            horizontalAlignment: Text.AlignHCenter

            color: colors.light
            font.family: fonts.primaryBold.name
            font.weight: Font.Bold
            font.pixelSize: 72
        }

        BruhTextField {
            Layout.fillWidth: true
        }

        BruhPasswordField {
            Layout.fillWidth: true
        }

        BruhButton {
            Layout.fillWidth: true

            text: "Bruh"
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
