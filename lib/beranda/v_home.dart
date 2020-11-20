import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../secrets.dart';
import '../beranda/components/map_pin_pill.dart';
import '../beranda/models/pin_pill_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const double CAMERA_ZOOM = 20;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(-8.785502, 115.199806);
// const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  BitmapDescriptor pinLocationIcon;
// for my drawn routes on the map
  // Set<Polyline> _polylines = Set<Polyline>();
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints;
  String googleAPIKey = Secrets.API_KEY;
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  // BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
  LocationData currentLocation;
// a reference to the destination location
  // LocationData destinationLocation;
// wrapper around the location API
  Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(-8.785502, 115.199806),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  // PinInformation destinationPinInfo;

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();
    // polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      print("INI LOKASI DRIVER: $cLoc");
      print("Lokasi lat : ${cLoc.latitude}");
      print("Lokasi Lng : ${cLoc.longitude}");
      _updateDriver(cLoc.latitude.toString(), cLoc.longitude.toString(),
          cLoc.heading.toString());
      setState(() {
        currentLocation = cLoc;
      });
      setCustomMapPin();
      _markers.add(Marker(
        markerId: MarkerId('lokasi_driver'),
        position: LatLng(
          cLoc.latitude,
          cLoc.longitude,
        ),
        rotation: cLoc.heading,
        infoWindow: InfoWindow(
          title: 'Lokasi saya',
          snippet: "lokasi saya",
        ),
        icon: pinLocationIcon,
      ));
      updatePinOnMap();
    });
    // set custom marker pins
    // setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5.0),
        'assets/images/logo_motor.png');
  }

  void _updateDriver(String lat, String lng, String heading) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var idUser = sharedPreferences.get("id_user");
    final response = await http.post(Secrets.BASE_URL + "update_lokasi_driver",
        body: {"lat": lat, "lng": lng, "bearing": heading, "id_user": idUser});
    final data = jsonDecode(response.body);
    print("post data : $lat $lng");
    print("hasil nya : $data");

    String value = data['status'];
    String pesan = data['pesan'];
    if (value == '1') {
      print(pesan);
    }
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/images/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    // BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
    //         'assets/destination_map_marker.png')
    //     .then((onValue) {
    //   destinationIcon = onValue;
    // });
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

    // hard-coded destination for this example
    // destinationLocation = LocationData.fromMap({
    //   "latitude": DEST_LOCATION.latitude,
    //   "longitude": DEST_LOCATION.longitude
    // });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              // polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onTap: (LatLng loc) {
                pinPillPosition = -100;
              },
              onMapCreated: (GoogleMapController controller) {
                // controller.setMapStyle(Utils.mapStyles);
                _controller.complete(controller);
                // my map has completed being created;
                // i'm ready to show the pins on the map
                showPinsOnMap();
              }),
          MapPinPillComponent(
              pinPillPosition: pinPillPosition,
              currentlySelectedPin: currentlySelectedPin)
        ],
      ),
    );
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    // var destPosition =
    //     LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: LatLng(currentLocation.latitude, currentLocation.longitude),
        pinPath: "assets/icons/driving_pin.png",
        avatarPath: "assets/images/friend1.jpg",
        labelColor: Colors.blueAccent);

    // destinationPinInfo = PinInformation(
    //     locationName: "End Location",
    //     location: DEST_LOCATION,
    //     pinPath: "assets/destination_map_marker.png",
    //     avatarPath: "assets/friend2.jpg",
    //     labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin
    // _markers.add(Marker(
    //     markerId: MarkerId('destPin'),
    //     position: destPosition,
    //     onTap: () {
    //       setState(() {
    //         currentlySelectedPin = destinationPinInfo;
    //         pinPillPosition = 0;
    //       });
    //     },
    //     icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    // setPolylines();
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }
}
