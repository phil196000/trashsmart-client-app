import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/schedule/data/schedule.dart';

class ScheduleService with ReactiveServiceMixin {
//  Write all Firebase Logic Here

  //2
  RxValue<List<Schedule>> _schedules = RxValue<List<Schedule>>(initial: []);

  List<Schedule> get schedules => _schedules.value;

  ScheduleService() {
    listenToReactiveValues([_schedules]);
    getSchedules();
  }

  getSchedules() {
    _schedules.value = [];

    FirebaseFirestore.instance
        .collection("requests")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        dynamic newRes = result.data();
        print("" + newRes["bagSize"].toString());

        List<String> days = [];
        for (String item in newRes["days"]) {
          days.add(item);
        }

        // Location
        Location location = new Location(
          lat: newRes["location"]["lat"],
          long: newRes["location"]["long"],
          name: newRes["location"]["name"],
        );
        _schedules.value.add(
          new Schedule(
            days: days,
            type: newRes["type"],
            payment: newRes["payment"],
            bagSize: newRes["bagSize"]["type"],
            count: newRes["bagSize"]["count"],
            price: newRes["price"],
            location: location,
          ),
        );
      });
    });
  }

  void createSchedule(Schedule data) {
    String userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection("requests").doc().set({
      "id": userId,
      "price": data.price,
      "days": data.days,
      "location": {
        "lat": data.location.lat,
        "long": data.location.long,
        "name": data.location.name
      },
      "type": data.type,
      "user_name ": "Username",
      "payment": data.payment,
      "bagSize": {"count": data.count, "type": data.bagSize}
    });
  }
}
