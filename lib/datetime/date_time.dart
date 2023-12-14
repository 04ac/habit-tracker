DateTime createDateTimeObject(String yyyymmdd) {
  int year = int.parse(yyyymmdd.substring(0, 4));
  int month = int.parse(yyyymmdd.substring(4, 6));
  int day = int.parse(yyyymmdd.substring(6, 8));

  return DateTime(year, month, day);
}

String convertDateTimeToString(DateTime date) {
  //year
  String yyyy = date.year.toString();

  //month
  String mm = date.month.toString();
  if (mm.length == 1) {
    mm = '0$mm';
  }

  //day
  String dd = date.day.toString();
  if (dd.length == 1) {
    dd = '0$dd';
  }

  return '$yyyy$mm$dd';
}

// Return today's date as yyyymmdd
String todaysDateFormatted() {
  DateTime today = DateTime.now();

  return convertDateTimeToString(today);
}
