
import 'dart:math';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatTimeGroup(String timeGroup, bool? isFullName) {
  initializeDateFormatting('ru_RU', null).then((_) {

  });
  try {
    timeGroup = timeGroup.trim();
    if (timeGroup.contains(":")) {
      final dateTime = DateTime.parse(timeGroup);
      return DateFormat.Hm().format(dateTime);
    } else {
      final date = DateTime.parse(timeGroup);
      return isFullName != null && isFullName ? DateFormat.MMMMd('ru_RU').format(date) : DateFormat.MMMd('ru_RU').format(date);
    }
  } catch (e) {
    return "Некорректный формат даты";
  }
}

Map<String, dynamic> GetPartedDate ({required String date}) {

  Map<String, dynamic> _dateParted = {
    'year' : "0",
    'month' : "0",
    'day' : "0",
    'hour' : "0",
    'minutes' : "0",
    'seconds' : "0",
  };

  DateTime _parsedDate;

  if (date.length == 16) {
    DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');

    _parsedDate = formatter.parse(date);
  } else {
    _parsedDate = DateTime.parse(date).toLocal();
  }



  _dateParted['year'] = _parsedDate.year.toString();
  _dateParted['month'] = _parsedDate.month.toString().padLeft(2, '0');
  _dateParted['day'] = _parsedDate.day.toString().padLeft(2, '0');
  _dateParted['hour'] = _parsedDate.hour.toString().padLeft(2, '0');
  _dateParted['minutes'] = _parsedDate.minute.toString().padLeft(2, '0');
  _dateParted['seconds'] = _parsedDate.second.toString().padLeft(2, '0');

  return _dateParted;
}

Map<String, dynamic> SecondsToDateMap({required String seconds}) {
  Map<String, dynamic> _timeParted = {
    'hours': "0",
    'minutes': "0",
    'seconds': "0",
    'milliseconds': "0",
  };

  // Разделяем строку на целую часть и дробную (миллисекунды)
  List<String> parts = seconds.split(".");
  int _totalSeconds = int.parse(parts[0]);
  int _milliseconds = parts.length > 1 ? int.parse(parts[1].substring(0, min(3, parts[1].length)).padRight(3, '0')) : 0;

  int _hours = _totalSeconds ~/ 3600;
  _totalSeconds %= 3600;
  int _minutes = _totalSeconds ~/ 60;
  _totalSeconds %= 60;

  _timeParted['hours'] = _hours.toString().padLeft(2, '0');
  _timeParted['minutes'] = _minutes.toString().padLeft(2, '0');
  _timeParted['seconds'] = _totalSeconds.toString().padLeft(2, '0');
  _timeParted['milliseconds'] = _milliseconds.toString().padLeft(3, '0');

  return _timeParted;
}