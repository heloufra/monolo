import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/models/address.dart';
import 'package:olo/screens/auth/saveaddress.dart';
import 'package:olo/screens/profile/address/editaddress.dart';

class Markentranceedit extends StatefulWidget {
  late LatLng center; 
  late Address address;
  Markentranceedit({super.key, required this.center, required this.address});

  @override
  State<Markentranceedit> createState() => _MapScreenState();
}

class _MapScreenState extends State<Markentranceedit> {
  
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
    context.go('/profile/address/edit', extra : {'address': widget.address, 'center': _markers.first.position});
  //  Navigator.pop(context, MaterialPageRoute(builder: (context) => EditAddressPage(center: _markers.first.position, address: widget.address,)));

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
