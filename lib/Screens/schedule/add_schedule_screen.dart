import 'dart:ui';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/schedule/data/schedule.dart';
import 'package:trashsmart/Screens/schedule/schedule_home_screen.dart';
import 'package:trashsmart/Screens/schedule/schedule_viewmodel.dart';
import 'package:trashsmart/Screens/schedule/theme/schedule_app_theme.dart';
// import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// Import the Google Maps package
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashsmart/Screens/product_details/theme/product_details_theme.dart';

// import 'package:stacked/stacked.dart';
class AddScheduleScreen extends StatelessWidget {
  GoogleMapController mapController;
  final Geolocator _geolocator = Geolocator();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleViewModel>.reactive(
      viewModelBuilder: () => ScheduleViewModel(),
      builder: (context, model, child) => Theme(
        data: ScheduleAppTheme.buildLightTheme(),
        child: Scaffold(
          body: Stack(children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getAppBarUI(context),
                    scheduleTypeUI(context, model),
                    daysScheduledUI(context, model),
                    paymentModeUI(context, model),
                    locationUI(context, model),
                    bagSizeUI(context, model)
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // Use this as the template
  // ScheduleListView()

  Widget scheduleTypeUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Select Schedule Type ',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            DropdownButton<String>(
              value: model.type,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                model.type = newValue;
              },
              items: model.types.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ]),
    );
  }

  Widget daysScheduledUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Days Scheduled',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Wrap(
              spacing: 10,
              children: List.generate(
                model.days.length,
                (index) => FilterChip(
                  selected: model.isDayChecked(model.days[index]),
                  label: Text(model.days[index],
                      style: TextStyle(color: Colors.white)),
                  // elevation: 10,
                  // pressElevation: 5,
                  // shadowColor: Colors.teal,
                  backgroundColor: Colors.black54,
                  selectedColor: Colors.blue,
                  onSelected: (bool selected) {
                    model.toggleDayChecked(model.days[index]);
                  },
                ),
              ),
            )
          ]),
    );
  }

  Widget paymentModeUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Payment Type',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            DropdownButton<String>(
              value: model.paymentOption,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                model.paymentOption = newValue;
              },
              items: model.paymentType
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ]),
    );
  }

  Widget locationUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Pickup Location',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            new Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                ChoiceChip(
                    label: Text('Select Location'),
                    selected: true,
                    onSelected: (bool selected) {
                      showBottomSheetModal(context, model);
                    }),
                SizedBox(
                  width: 20,
                ),
                ActionChip(
                  avatar: Icon(Icons.location_on),
                  label: Text('Use Current Location'),
                  onPressed: () {},
                ),
              ],
            ),
          ]),
    );
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ScheduleAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Add Schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bagSizeUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Text(
                  'Bag Sizes',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: model.bagSize,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    model.bagSize = newValue;
                  },
                  items: model.bagList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            TextField(
              onChanged: (value) {
                model.bagNumber = value;
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a number of bags'),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                model.saveSchedule();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleHomeScreen(),
                    ),
                    (route) => false);
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: ProductDetailsAppTheme.nearlyBlue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color:
                            ProductDetailsAppTheme.nearlyBlue.withOpacity(0.5),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Add To Schedule',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 0.0,
                      color: ProductDetailsAppTheme.nearlyWhite,
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }

  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  LatLng pinPosition = LatLng(37.3797536, -122.1017334);

  // Method for retrieving the current location

  showBagListModal(BuildContext context, ScheduleViewModel model) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showMaterialModalBottomSheet(
        context: context,
        expand: false,
        isDismissible: false,
        builder: (context) => ListView.builder(
            // shrinkWrap: true,
            itemCount: model.bagList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(child: Text("" + model.bagList[index]));
            }));
  }

  showBottomSheetModal(BuildContext context, model) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => GestureDetector(
        // onTap: () => model.longUpdateStuff(),
        child: Container(
          height: height,
          width: width,
          child: Scaffold(
            body: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                // Replace the "TODO" with this widget
                GoogleMap(
                    initialCameraPosition: _initialLocation,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    onTap: (argument) {
                      model.latLng = argument;
                      print(argument);
                      model.location = argument.toString();
                      Navigator.of(context).pop();
                    },
                    onMapCreated: (GoogleMapController controller) {
                      // controller.setMapStyle(Utils.mapStyles);
                      mapController = controller;

                      // todo Investigate show all markers
                      // showAllMarkerInfo();
                    }),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 20, 120),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.orange[100], // button color
                          child: InkWell(
                            splashColor: Colors.orange, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.my_location),
                            ),
                            onTap: () {
                              _getCurrentLocation();
                              // on button tap
                            },
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.orange[100], // button color
                          child: InkWell(
                            splashColor: Colors.orange, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.cancel),
                            ),
                            onTap: () {
                              // _getCurrentLocation();
                              // on button tap

                              Navigator.of(context).pop();
                              print("Remove Context");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   // Method for retrieving the current location
  Position _currentPosition = null;
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // Store the position in the variable
      _currentPosition = position;

      print('CURRENT POS: $_currentPosition');

      // For moving the camera to current location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
    }).catchError((e) {
      print(e);
    });
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
