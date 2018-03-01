#include "CustomModel.h"

CustomModel::CustomModel(QObject* parent) :
	QObject(parent)
{

	connect(this, &CustomModel::elementsChanged, [this](){
		const int newSize = m_elements.size();
		if (m_count != newSize) {
			m_count = newSize;
			emit countChanged();
		}
	});

	QDate initial(2017, 12, 31);

	setElements(
		   QMap<QDate, QMap<int, double>>({
			{initial.addDays(1),  {{1, 55}}},
			{initial.addDays(2),  {{1, 78}}},
			{initial.addDays(3),  {{1, 76}}},
			{initial.addDays(4),  {{1, 107}}},
			{initial.addDays(5),  {{1, 96}}},
			{initial.addDays(6),  {{1, 102}}},
			{initial.addDays(7),  {{1, 88}}},
			{initial.addDays(8),  {{1, 96}}},
			{initial.addDays(9),  {{1, 70}}},
			{initial.addDays(10),  {{1, 55}}},
			{initial.addDays(11),  {{1, 77}}},
			{initial.addDays(12),  {{1, 61}}},
			{initial.addDays(13),  {{1, 51}}},
			{initial.addDays(14),  {{1, 76}}},
			{initial.addDays(15),  {{1, 57}}},
			{initial.addDays(16),  {{1, 76}}},
			{initial.addDays(17),  {{1, 61}}},
			{initial.addDays(18),  {{1, 83}}},
			{initial.addDays(19),  {{1, 78}}},
			{initial.addDays(20),  {{1, 98}}},
			{initial.addDays(21),  {{1, 82}}},
			{initial.addDays(22),  {{1, 88}}},
			{initial.addDays(23),  {{1, 115}}},
			{initial.addDays(24),  {{1, 139}}},
			{initial.addDays(25),  {{1, 132}}},
			{initial.addDays(26),  {{1, 183}}},
			{initial.addDays(27),  {{1, 209}}},
			{initial.addDays(28),  {{1, 262}}},
			{initial.addDays(29),  {{1, 242}}},
			{initial.addDays(30),  {{1, 253}}},
			{initial.addDays(31),  {{1, 226}}},
			{initial.addDays(32),  {{1, 252}}},
			{initial.addDays(33),  {{1, 327}}},
			{initial.addDays(34),  {{1, 234}}},
			{initial.addDays(35),  {{1, 287}}},
			{initial.addDays(36),  {{1, 365}}},
			{initial.addDays(37),  {{1, 361}}},
			{initial.addDays(38),  {{1, 432}}},
			{initial.addDays(39),  {{1, 371}}},
			{initial.addDays(40),  {{1, 526}}},
			{initial.addDays(41),  {{1, 461}}},
			{initial.addDays(42),  {{1, 496}}},
			{initial.addDays(43),  {{1, 506}}},
			{initial.addDays(44),  {{1, 527}}},
			{initial.addDays(45),  {{1, 458}}},
			{initial.addDays(46),  {{1, 636}}},
			{initial.addDays(47),  {{1, 583}}},
			{initial.addDays(48),  {{1, 574}}},
			{initial.addDays(49),  {{1, 671}}},
			{initial.addDays(50),  {{1, 508}}},
			{initial.addDays(51),  {{1, 588}}},
			{initial.addDays(52),  {{1, 590}}},
			{initial.addDays(53),  {{1, 642}}},
			{initial.addDays(54),  {{1, 695}}},
			{initial.addDays(55),  {{1, 955}}},
			{initial.addDays(56),  {{1, 1112}}},
			{initial.addDays(57),  {{1, 966}}},
			{initial.addDays(58),  {{1, 1174}}},
			{initial.addDays(59),  {{1, 1163}}},
			{initial.addDays(60),  {{1, 826}}},
			{initial.addDays(61),  {{1, 976}}},
			{initial.addDays(62),  {{1, 575}}},
			{initial.addDays(63),  {{1, 612}}},
			{initial.addDays(64),  {{1, 776}}},
			{initial.addDays(65),  {{1, 508}}},
			{initial.addDays(66),  {{1, 426}}},
			{initial.addDays(67),  {{1, 453}}},
			{initial.addDays(68),  {{1, 455}}},
			{initial.addDays(69),  {{1, 427}}},
			{initial.addDays(70),  {{1, 297}}},
			{initial.addDays(71),  {{1, 393}}},
			{initial.addDays(72),  {{1, 371}}},
			{initial.addDays(73),  {{1, 450}}},
			{initial.addDays(74),  {{1, 424}}},
			{initial.addDays(75),  {{1, 375}}},
			{initial.addDays(76),  {{1, 346}}},
			{initial.addDays(77),  {{1, 393}}},
			{initial.addDays(78),  {{1, 327}}},
			{initial.addDays(79),  {{1, 415}}},
			{initial.addDays(80),  {{1, 251}}},
			{initial.addDays(81),  {{1, 229}}},
			{initial.addDays(82),  {{1, 295}}},
			{initial.addDays(83),  {{1, 311}}},
			{initial.addDays(84),  {{1, 335}}},
			{initial.addDays(85),  {{1, 266}}},
			{initial.addDays(86),  {{1, 268}}},
			{initial.addDays(87),  {{1, 271}}},
			{initial.addDays(88),  {{1, 265}}},
			{initial.addDays(89),  {{1, 261}}},
			{initial.addDays(90),  {{1, 232}}},
			{initial.addDays(91),  {{1, 180}}},
			{initial.addDays(92),  {{1, 152}}},
			{initial.addDays(93),  {{1, 178}}},
			{initial.addDays(94),  {{1, 177}}},
			{initial.addDays(95),  {{1, 218}}},
			{initial.addDays(96),  {{1, 166}}},
			{initial.addDays(97),  {{1, 116}}},
			{initial.addDays(98),  {{1, 162}}},
			{initial.addDays(99),  {{1, 162}}},
			{initial.addDays(100),  {{1, 168}}},
			{initial.addDays(101),  {{1, 137}}},
			{initial.addDays(102),  {{1, 142}}},
			{initial.addDays(103),  {{1, 145}}},
			{initial.addDays(104),  {{1, 161}}},
			{initial.addDays(105),  {{1, 141}}},
			{initial.addDays(106),  {{1, 107}}},
			{initial.addDays(107),  {{1, 107}}},
			{initial.addDays(108),  {{1, 75}}},
			{initial.addDays(109),  {{1, 91}}},
			{initial.addDays(110),  {{1, 93}}},
			{initial.addDays(111),  {{1, 84}}},
			{initial.addDays(112),  {{1, 99}}},
			{initial.addDays(113),  {{1, 59}}},
			{initial.addDays(114),  {{1, 58}}},
			{initial.addDays(115),  {{1, 49}}},
			{initial.addDays(116),  {{1, 67}}},
			{initial.addDays(117),  {{1, 45}}},
			{initial.addDays(118),  {{1, 59}}},
			{initial.addDays(119),  {{1, 64}}},
			{initial.addDays(120),  {{1, 81}}},
			{initial.addDays(121),  {{1, 83}}},
			{initial.addDays(122),  {{1, 101}}},
			{initial.addDays(123),  {{1, 75}}},
			{initial.addDays(124),  {{1, 71}}},
			{initial.addDays(125),  {{1, 100}}},
			{initial.addDays(126),  {{1, 122}}},
			{initial.addDays(127),  {{1, 131}}},
			{initial.addDays(128),  {{1, 87}}},
			{initial.addDays(129),  {{1, 75}}},
			{initial.addDays(130),  {{1, 71}}},
			{initial.addDays(131),  {{1, 83}}},
			{initial.addDays(132),  {{1, 85}}},
			{initial.addDays(133),  {{1, 69}}},
			{initial.addDays(134),  {{1, 64}}},
			{initial.addDays(135),  {{1, 53}}},
			{initial.addDays(136),  {{1, 75}}},
			{initial.addDays(137),  {{1, 79}}},
			{initial.addDays(138),  {{1, 93}}}
										  }));
}

QMap<QDate, QMap<int, double> > CustomModel::getElements()
{
	return m_elements;
}

void CustomModel::setElements(const QMap<QDate, QMap<int, double> >& s)
{
	m_elements = s;
	emit elementsChanged();
}

int CustomModel::count()
{
	return m_count;
}

void CustomModel::setCount(const int c)
{
	m_count = c;
}

QPair<QDate, QMap<int, double>> CustomModel::get(const int index)
{
	if (m_elements.size() <= index) {
		return qMakePair(QDate(), QMap<int, double>());
	}
	auto iter = m_elements.begin() + index;
	return qMakePair(iter.key(), iter.value());
}

QString CustomModel::getValueX(const int index, const QString& format)
{
	if (m_elements.size() <= index || index < 0) {
		return QString();
	}
	return (m_elements.begin() + index).key().toString(format);
}

double CustomModel::getValueY(const int index)
{
	if (m_elements.size() <= index || index < 0) {
		return 0;
	}
	auto val = (m_elements.begin() + index).value();
	return val.isEmpty() ? 0 : val.begin().value();
}

QString CustomModel::getValueYComment(const int index, const QString& format)
{
	if (m_elements.size() <= index || index < 0) {
		return QString();
	}
	auto val = (m_elements.begin() + index).value();
	if (val.isEmpty()) {
		return QString();
	}
	return QString("Id:%1; Date: %2; Value: %3").arg(val.begin().key()).arg(getValueX(index, format)).arg(val.begin().value());
}
