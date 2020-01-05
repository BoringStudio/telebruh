import QtQuick 2.13
import QtQuick.Controls 2.13

Button {
    implicitHeight: 36

    id: component

    contentItem: Text {
        text: component.text

        color: colors.semidark

        font.family: fonts.primaryBold.name
        font.weight: Font.Bold
        font.pixelSize: 18

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        radius: 3

        color: colors.primary
    }
}
