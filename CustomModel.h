#pragma once
#include <QObject>
#include <QSize>
#include <QMap>
#include <QDate>


class CustomModel : public QObject {
	Q_OBJECT

	Q_PROPERTY(QMap<QDate, QMap<int, double>> elements READ getElements WRITE setElements NOTIFY elementsChanged)
	Q_PROPERTY(int count READ count WRITE setCount  NOTIFY countChanged)
public:
	explicit CustomModel(QObject *parent = nullptr);

	QMap<QDate, QMap<int, double>> getElements();
	void setElements(const QMap<QDate, QMap<int, double>>& s);
	int count();
	void setCount(const int c);

	Q_INVOKABLE QPair<QDate, QMap<int, double> > get(const int index);
	Q_INVOKABLE QString getValueX(const int index, const QString& format);
	Q_INVOKABLE double getValueY(const int index);
	Q_INVOKABLE QString getValueYComment(const int index, const QString& format);
signals:
	void elementsChanged();
	void countChanged();

private:
	QMap<QDate, QMap<int, double>> m_elements;
	int m_count = 0;
};

