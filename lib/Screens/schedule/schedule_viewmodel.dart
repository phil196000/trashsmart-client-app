import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  List<String> types = ["ONE TIME", "WEEKLY", "MONTHLY"];
  List<String> paymentType = ["In Person", "MOMO"];

  List<Schedule> get popularSchedules => allSchedules;
  String get scheduleTypeValue => _scheduleType;
  List<String> get days =>
      ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  List<String> get bagList => ["Small", "Medium", "Large"];

  String type = "WEEKLY";
  // Get a list of selected schedule days
  List<String> selectedDays = [];
  Set<String> checkedDays = new Set<String>();
  String paymentOption = "In Person";
  String location = "";
  String bagSize = "Small";
  String bagNumber = "1";
  String _scheduleType = "WEEKLY";

  LatLng latLng = null;

  ScheduleViewModel() {
    getAllSchedules();
  }

  List<Schedule> allSchedules = [];

  // get all schedules
  getAllSchedules() {
    setBusy(true);
    _informationService.getSchedules();
    allSchedules = _informationService.schedules;
    setBusy(false);
  }

  handleScheduleTypeChange(ScheduleType scheduleValue) {
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

  bool saveSchedule() {
    setBusy(true);
    // final coordinates = new Coordinates(1.10, 45.50);
    // List<Address> addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // Address first = addresses.first;

    Schedule data = new Schedule(
        type: this._scheduleType,
        days: this.checkedDays.toList(),
        price: 200, //compute price
        location: new Location(lat: "1234", long: "1234", name: "Ayeduase"),
        payment: this.paymentOption,
        bagSize: this.bagSize,
        count: int.parse(this.bagNumber));
    // print(first);

    this._informationService.createSchedule(data);
    // setBusy(false);

    return true;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
