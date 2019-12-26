// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

int main(int argc, char** argv)
{
    QApplication application{ argc, argv };

    QQmlApplicationEngine viewEngine{ QUrl("qrc:/main.qml") };

    return QApplication::exec();
}
