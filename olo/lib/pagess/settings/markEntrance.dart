import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/pagess/settings/saveaddress.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  late LatLng center;
  MapScreen({super.key, required this.center});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng initialLocation;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final List<Marker> _markers = [];

  late GoogleMapController mapController;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
    initialLocation = widget.center;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getCurrentLocation();
    final marker = Marker(
      markerId: MarkerId('_currentLocation'),
      position: LatLng(initialLocation.latitude, initialLocation.longitude),
      icon: markerIcon,
    );
    _markers.add(marker);
  }

  Future<void> _askForLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SaveAddressPage(
                  center: initialLocation,
                )
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        initialLocation = LatLng(position.latitude, position.longitude);
      });
      mapController.animateCamera(CameraUpdate.newLatLng(initialLocation));
      print('Current location: $initialLocation');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(),
            "assets/images/noun-home-map-pin-805793.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void saveAddress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SaveAddressPage(
                center: initialLocation,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mark Entrance'),
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(

        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialLocation,
            zoom: 16.9,
          ),
          mapType: MapType.terrain,
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          // myLocationEnabled: true,
          markers: _markers.toSet(),
          onCameraMove: (position) {
            setState(() {
              _markers.first =
                  _markers.first.copyWith(positionParam: position.target);
            });
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        color: Colors.transparent,
        child: Continue(onTap: saveAddress, enable: true, textbutton: 'Save'),
        elevation: 0,
      ),
    );
  }
}
