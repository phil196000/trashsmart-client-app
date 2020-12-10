import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/schedule/data/schedule.dart';

/*
 * 1. Location
 * 2. Duration / Time / Date
 * payment weekely / pay as you you (in person)
 */
class ScheduleViewModel extends BaseViewModel {
  List<Schedule> get popularSchedules => <Schedule>[
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

  int scheduleType = 0;
  int get scheduleTypeValue => scheduleType;

  handleScheduleTypeChange(int scheduleValue) {
    // this.scheduleType = scheduleValue;
    // this.notifyListeners();
    print("Radio Changed " + scheduleValue.toString());
  }
}
