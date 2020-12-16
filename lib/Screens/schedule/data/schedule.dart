class Schedule {
  Schedule({
    this.name = '',
    this.time = 0,
    this.money = 0,
    this.type,
  });

  String name;
  int time;
  int money;
  final String type;
}

enum ScheduleType { ONE_TIME, WEEKLY, MONTHLY }
