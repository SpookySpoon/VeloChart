#pragma once
#include <QObject>
#include <QSize>

class RenderAxY : public QObject
{
	Q_OBJECT
//	Q_PROPERTY(QSize size READ getSize WRITE setSize NOTIFY sizeChanged)

//	Q_PROPERTY(QMap<QMap<>> size READ getSize WRITE setSize NOTIFY sizeChanged)
public:
//	explicit RenderAxY(QObject *parent = nullptr);

	Q_INVOKABLE void lalaHer();
//	QSize getSize();
//	void setSize(const QSize& s);
//	int getSomething() {
//		return 100;
//	}

//signals:
//	void sizeChanged();

//private:
//	QSize m_size = QSize(5,6);
};
