class Schedule {
  Schedule({
    this.name = '',
    this.time = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String name;
  int time;
  int money;
  double rating;

  static List<Schedule> scheduleList = <Schedule>[
    Schedule(name: 'User interface Design', money: 25, rating: 4.3, time: 8),
    Schedule(
      name: 'User interface Design',
      time: 22,
      money: 18,
      rating: 4.6,
    ),
    Schedule(
      name: 'User interface Design',
      time: 24,
      money: 25,
      rating: 4.3,
    ),
    Schedule(
      name: 'User interface Design',
      time: 22,
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Schedule> popularCourseList = <Schedule>[
    Schedule(
      name: 'App Design Course',
      time: 12,
      money: 25,
      rating: 4.8,
    ),
    Schedule(
      name: 'Web Design Course',
      time: 28,
      money: 208,
      rating: 4.9,
    ),
    Schedule(
      name: 'App Design Course',
      time: 12,
      money: 25,
      rating: 4.8,
    ),
    Schedule(
      name: 'Web Design Course',
      time: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
