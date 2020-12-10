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
          name: 'KentinKrono',
          time: 12,
          money: 250,
        ),
        Schedule(
          name: 'Nsenie',
          time: 28,
          money: 208,
        ),
        Schedule(
          name: 'Boadi',
          time: 12,
          money: 25,
        ),
        Schedule(
          name: 'Ejisu',
          time: 28,
          money: 208,
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
