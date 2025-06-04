extension DateComparison on DateTime {
  bool isSameDay(DateTime other) {
    return day == other.day && year == other.year;
  }
}
