import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppState extends ChangeNotifier {
  bool isenglish = true;
  static LatLng _initialPosition;
  static LatLng _selectpickPosition;
  static LatLng _dropoffPosition;

  LatLng _lastPosition = _initialPosition;
  LatLng _lastselectpickPosition = _initialPosition;
  LatLng _lastdropoffposition = _dropoffPosition;

  final Set<Marker> _markers = {};

  final Set<Polyline> _polyLines = {};
  final Set<Polyline> _polyLines2 = {};
  GoogleMapController _mapController;
  TextEditingController locationController = TextEditingController();

  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  LatLng get selectpickPosition => _selectpickPosition;
  LatLng get lastselectpickPosition => _lastselectpickPosition;
  LatLng get dropoffPosition => _dropoffPosition;
  LatLng get lastdropoffposition => _lastdropoffposition;

  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;
  Set<Polyline> get polyLines2 => _polyLines2;
  AppState() {
    print("shida ni gani");
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    print("initial position is : ${_initialPosition.toString()}");
    locationController.text = placemark[0].name;
    addMarker(_initialPosition, locationController.text);
    notifyListeners();
  }

  void addMarker(LatLng locations, String adddress) async {
    _markers.add(Marker(
      draggable: true,
      onDragEnd: (v) {
        print(v);
      },
      markerId: MarkerId(locations.toString()),
      position: locations,
      onTap: () {
        debugPrint('$locations');
      },
      infoWindow: InfoWindow(title: adddress, snippet: "Location"),
    ));
    // notifyListeners();
  }

  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    // notifyListeners();
  }

  void onCreated(GoogleMapController controller) async {
    _mapController = controller;
  }
}
