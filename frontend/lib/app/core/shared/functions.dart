String printDate(DateTime dateTime) {
  return dateTime.toString().substring(0, 10);
}

DateTime firstDayInLastMonth() {
  DateTime now = DateTime.now();

  return DateTime(now.year, now.month);
}
