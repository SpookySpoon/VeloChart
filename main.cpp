#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "CustomModel.h"


int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);
	qmlRegisterType<CustomModel>("MyCustomModel", 1, 0, "CustomModel");
	qmlRegisterSingletonType(QUrl("qrc:/StaticFunctions.qml"), "Utils", 1, 0, "Utils");

	QQmlApplicationEngine engine;
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
