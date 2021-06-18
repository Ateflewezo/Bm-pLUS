class Date {
  String day;
  String month;
  String year;
  String week;
  String hour;
  String minut;
  String id;

  Date({this.day, this.month, this.year, this.week});
  Date.fromMap(Map snapshot, String id)
      : id = id ?? '',
        day = snapshot['day'] ?? '',
        hour = snapshot['hour'] ?? '',
        minut = snapshot['minut'] ?? '',
        month = snapshot['month'] ?? '',
        week = snapshot['week'] ?? '',
        year = snapshot['year'] ?? '';

  toJson() {
    return {
      "day": day,
      "hour": DateTime.now().hour.toString(),
      "minut": DateTime.now().minute.toString(),
      "month": month,
      "week": week,
      "year": year,
    };
  }

  int isoWeekNumber(DateTime date) {
    int daysToAdd = DateTime.thursday - date.weekday;
    DateTime thursdayDate = daysToAdd > 0
        ? date.add(Duration(days: daysToAdd))
        : date.subtract(Duration(days: daysToAdd.abs()));
    int dayOfYearThursday = dayOfYear(thursdayDate);
    return 1 + ((dayOfYearThursday - 1) / 7).floor();
  }

  int dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays;
  }
}
