class DateUtils1 {
  static timestamp() {
    DateTime time = DateTime.now();
    return "${time.hour.toString()}:${time.minute.toString()}:${time.second.toString()}";
  }
}
