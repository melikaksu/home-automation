DateTime getMonday() {
  DateTime monday = DateTime.now();
  while (monday.weekday != 1) {
    monday = monday.subtract(Duration(days: 1));
  }
  return monday;
}

DateTime getSunday() {
  DateTime sunday = DateTime.now();
  while (sunday.weekday != 7 ) {
    sunday = sunday.add(Duration(days: 1,));
  }
  return sunday;
}
