class Schedule {
  Schedule({
    this.count,
    this.days,
    this.price,
    this.type,
    this.bagSize,
    this.payment,
    this.location,
  });

  final List<String> days;
  final double price;
  final String type;
  final String bagSize;
  final int count;
  final String payment;
  final Location location;
}

class Location {
  final String lat;
  final String long;
  final String name;

  Location({this.lat, this.long, this.name});
}

enum ScheduleType { ONE_TIME, WEEKLY, MONTHLY }
