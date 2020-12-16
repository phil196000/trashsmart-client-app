import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/schedule/data/schedule.dart';
import 'package:trashsmart/app/locator.dart';
import 'package:trashsmart/core/services/schedule.service.dart';

/*
 * 1. Location
 * 2. Duration / Time / Date
 * payment weekely / pay as you you (in person)
 */
class ScheduleViewModel extends ReactiveViewModel {
  final ScheduleService _informationService = locator<ScheduleService>();

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

  ScheduleType get scheduleTypeValue => _scheduleType;

  List<String> get days =>
      ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  List<String> get bagList => ["Small", "Medium", "Large"];

  // Get a list of selected schedule days
  List<String> selectedDays = [];

  Set<String> checkedDays = new Set<String>();
  String _paymentOption = "IN_PERSON";
  String location = "";
  String _bagType = "";
  int _bagNumber = 1;

  //SET Initial Schedule Type to Weekely
  ScheduleType _scheduleType = ScheduleType.WEEKLY;

  handleScheduleTypeChange(ScheduleType scheduleValue) {
    this._scheduleType = scheduleValue;
    this.notifyListeners();
    print("Radio Changed " + scheduleValue.toString());
  }

  bool isDayChecked(value) {
    return checkedDays.contains(value);
  }

  void toggleDayChecked(day) {
    if (checkedDays.contains(day)) {
      checkedDays.remove(day);
    } else {
      checkedDays.add(day);
    }
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
