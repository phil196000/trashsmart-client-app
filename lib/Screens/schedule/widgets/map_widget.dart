// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// // Import the Google Maps package
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:stacked/stacked.dart';

// class MapsScreen extends StatefulWidget {
//   @override
//   _MapViewState createState() => _MapViewState();
// }

// class _MapViewState extends State<MapsScreen> {
//   // Initial location of the Map view
//   CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
//   BitmapDescriptor pinLocationIcon;
//   Set<Marker> _markers = {};
//   LatLng pinPosition = LatLng(37.3797536, -122.1017334);
//   bool detailsState = false;
// // For controlling the view of the Map
//   GoogleMapController mapController;
//   final Geolocator _geolocator = Geolocator();

// // For storing the current position
//   Position _currentPosition;
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();

//     BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
//             'assets/destination_map_marker.png')
//         .then((onValue) {
//       pinLocationIcon = onValue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Determining the screen width & height
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     return ViewModelBuilder<HomeViewModel>.reactive(
//         viewModelBuilder: () => HomeViewModel(),
//         // onModelReady: () =>  ,
//         builder: (context, model, child) {
//           // put code to build the model markers

//           // Return the maps
//           return GestureDetector(
//             // onTap: () => model.longUpdateStuff(),
//             child: Container(
//               height: height,
//               width: width,
//               child: Scaffold(
//                 body: Stack(
//                   alignment: Alignment.bottomRight,
//                   children: <Widget>[
//                     // Replace the "TODO" with this widget
//                     GoogleMap(
//                         initialCameraPosition: _initialLocation,
//                         myLocationEnabled: true,
//                         myLocationButtonEnabled: false,
//                         mapType: MapType.normal,
//                         zoomGesturesEnabled: true,
//                         zoomControlsEnabled: false,
//                         markers: _markers,
//                         onTap: (argument) {
//                           setState(() {
//                             detailsState = false;
//                           });
//                         },
//                         onMapCreated: (GoogleMapController controller) {
//                           controller.setMapStyle(Utils.mapStyles);
//                           mapController = controller;

//                           // todo Investigate show all markers
//                           // showAllMarkerInfo();
//                         }),

//                     Container(
//                       margin: EdgeInsets.fromLTRB(10, 0, 20, 120),
//                       child: ClipOval(
//                         child: Material(
//                           color: Colors.orange[100], // button color
//                           child: InkWell(
//                             splashColor: Colors.orange, // inkwell color
//                             child: SizedBox(
//                               width: 56,
//                               height: 56,
//                               child: Icon(Icons.my_location),
//                             ),
//                             onTap: () {
//                               _getCurrentLocation();
//                               // on button tap
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   showAllMarkerInfo() {
//     for (Marker maker in _markers) {
//       mapController.showMarkerInfoWindow(maker.markerId);
//     }
//   }

//   // Method for retrieving the current location
//   _getCurrentLocation() async {
//     await _geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         // Store the position in the variable
//         _currentPosition = position;

//         print('CURRENT POS: $_currentPosition');

//         // For moving the camera to current location
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
// }

// class Utils {
//   static String mapStyles = '''[
//   {
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.icon",
//     "stylers": [
//       {
//         "visibility": "off"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#616161"
//       }
//     ]
//   },
//   {
//     "elementType": "labels.text.stroke",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "featureType": "administrative.land_parcel",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#bdbdbd"
//       }
//     ]
//   },
//   {
//     "featureType": "poi",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#eeeeee"
//       }
//     ]
//   },
//   {
//     "featureType": "poi",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#757575"
//       }
//     ]
//   },
//   {
//     "featureType": "poi.park",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#e5e5e5"
//       }
//     ]
//   },
//   {
//     "featureType": "poi.park",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   },
//   {
//     "featureType": "road",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#ffffff"
//       }
//     ]
//   },
//   {
//     "featureType": "road.arterial",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#757575"
//       }
//     ]
//   },
//   {
//     "featureType": "road.highway",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#dadada"
//       }
//     ]
//   },
//   {
//     "featureType": "road.highway",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#616161"
//       }
//     ]
//   },
//   {
//     "featureType": "road.local",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   },
//   {
//     "featureType": "transit.line",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#e5e5e5"
//       }
//     ]
//   },
//   {
//     "featureType": "transit.station",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#eeeeee"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#c9c9c9"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   }
// ]''';
// }
