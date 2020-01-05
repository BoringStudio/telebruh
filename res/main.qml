import QtQuick 2.14
import QtQuick.Controls 2.14

import "./views"

ApplicationWindow {
    Item {
        id: colors

        readonly property string dark: "#14100E"
        readonly property string semidark: "#28201C"
        readonly property string light: "#EAE8E8"
        readonly property string primary: "#F4AC45"
    }

    Item {
        id: fonts

        readonly property FontLoader primaryBold: FontLoader {
            source: "fonts/PTSans-Bold.ttf"
        }
        readonly property FontLoader primaryBoldItalic: FontLoader {
            source: "fonts/PTSans-BoldItalic.ttf"
        }
        readonly property FontLoader primaryItalic: FontLoader {
            source: "fonts/PTSans-Italic.ttf"
        }
        readonly property FontLoader primaryRegular: FontLoader {
            source: "fonts/PTSans-Regular.ttf"
        }
    }

    id: window
    visible: true
    width: 900
    height: 600

    background: Rectangle {
        id: background
        color: colors.semidark
    }

    StackView {
        id: viewsContainer

        anchors.fill: parent
        initialItem: loginView
    }

    Component {
        id: loginView

        LoginView {
        }
    }
}
