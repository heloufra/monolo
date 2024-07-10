import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/homepage.dart';
import 'package:olo/pagess/settings/markEntrance.dart';
import 'package:olo/services/clientService.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveAddressPage extends StatefulWidget {
  LatLng? center;
  SaveAddressPage({super.key, this.center});

  @override
  State<SaveAddressPage> createState() => _SaveAddressPageState();
}

class _SaveAddressPageState extends State<SaveAddressPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final ClientService clientService = ClientService();
  late BitmapDescriptor markerIcon;

  bool showError = false;
  String errorMessage = '';

  bool enableSave = false;
  late GoogleMapController mapController;

  late LatLng _center;

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    nameController.addListener(checkEnableSave);
    addressController.addListener(checkEnableSave);
    phoneController.addListener(checkEnableSave);
    _center = widget.center ?? LatLng(37.422131, -122.084801);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getCurrentLocation();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(),
            "/Users/Hamza/mono-olo-ropo/olo/assets/images/noun-home-map-pin-805793.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  Future<void> _askForLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print('Location permission denied');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
      });
      mapController.animateCamera(CameraUpdate.newLatLng(_center));
      print('Current location: $_center');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _mapClicked(LatLng latLng) {
    print('Map clicked');
  }

  void checkEnableSave() {
    final phoneValid = RegExp(r'^\d+$').hasMatch(phoneController.text);

    if (phoneValid || phoneController.text.isEmpty) {
      setState(() {
        showError = false;
        errorMessage = '';
      });
    } else {
      setState(() {
        showError = true;
        errorMessage = 'Phone number must contain only digits';
      });
    }

    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      setState(() {
        enableSave = true;
      });
    } else {
      setState(() {
        enableSave = false;
      });
    }
  }

  void saveAddress() async {
    if (enableSave) {
      setState(() {
        enableSave = false;
      });
      // print(mapController.showMarkerInfoWindow(MarkerId('_currentLocation')));
      var (success, msg) = await clientService.newAddressRegister(
          nameController.text,
          addressController.text,
          phoneController.text,
          _center.latitude,
          _center.longitude);

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        setState(() {
          showError = true;
          errorMessage = msg;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text('Save Addres'),
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.9,
                ),
                onTap: (LatLng latLng) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen(center: latLng,)),
                  );
                },
                markers: {
                  Marker(
                      markerId: MarkerId('_currentLocation'),
                      position: _center,
                      icon: markerIcon,
                      onDragEnd: ((newPosition) {
                        _center = newPosition;
                      })),
                },
              ),
            ),
            Text(
              addressController.text,
              style: TextStyle(fontSize: 16),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.1,
              indent: 0,
            ),
            SizedBox(height: 10),
            Text('Name', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Add a name for this address so you can find it easily later.',
              ),
            ),
            SizedBox(height: 16),
            Text('Address', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'House or apartment number, floor...'),
              maxLines: 1,
              minLines: 1,
            ),
            SizedBox(height: 16),
            Text('Phone number', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 90,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: '+212',
                    items: ['+212'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle phone code change
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your phone number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            showError
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox(),
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        color: Colors.transparent,
        child: Continue(
            onTap: enableSave ? saveAddress : null,
            enable: enableSave,
            textbutton: 'Save Address'),
        elevation: 0,
      ),
    );
  }
}
