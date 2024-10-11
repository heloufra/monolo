import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/screens/auth/saveaddress.dart';

class MapScreen extends StatefulWidget {
  late LatLng center;
  MapScreen({super.key, required this.center});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final List<Marker> _markers = [];

  late GoogleMapController mapController;

  @override
  void initState() {
    addCustomIcon();
    addMarker();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
 
    // addMarker();
  }

  Future<void> addCustomIcon() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/images/homeIcon.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );

       final marker = Marker(
      markerId: MarkerId('_currentLocation'),
      position: widget.center,
      icon: markerIcon,
    );
    _markers.add(marker);
  }

  void addMarker() {
    
  }

  void saveAddress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SaveAddressPage(
                center: _markers.first.position,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mark Entrance'),
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.center,
            zoom: 16.9,
          ),
          myLocationButtonEnabled: false,
          mapType: MapType.terrain,
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          // myLocationEnabled: true,
          markers: _markers.toSet(),
          // markers: {
          //   Marker(
          //       markerId: MarkerId('_currentLocation'),
          //       position: widget.center,
          //       icon: markerIcon,
          //       onDragEnd: ((newPosition) {
          //         widget.center = newPosition;
          //       })),
          // },
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
