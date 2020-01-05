import QtQuick 2.13
import QtQuick.Controls 2.13

TextField {
    id: component

    implicitHeight: 36

    padding: 5

    color: colors.light
    selectedTextColor: colors.dark
    selectionColor: colors.primary

    selectByMouse: true

    font.family: fonts.primaryRegular.name
    font.pointSize: 14
    font.weight: Font.Bold

    background: Rectangle {
        radius: 3

        color: colors.dark
    }

    cursorDelegate: Item {
        visible: component.cursorVisible
        width: component.cursorRectangle.width

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            width: parent.width
            implicitHeight: 18

            color: colors.light
        }
    }
}
