import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/components/textfield.dart';
import 'package:olo/homepage.dart';
import 'package:olo/screens/auth/markEntrance.dart';
import 'package:olo/services/user.dart';
import 'package:olo/utlis/toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

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
  UserService userService = UserService();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  bool enableSave = false;
  late GoogleMapController mapController;

  late LatLng _center;

  @override
  void initState() {
    super.initState();
    _addCustomIcon();
    nameController.addListener(checkEnableSave);
    addressController.addListener(checkEnableSave);
    phoneController.addListener(checkEnableSave);
    _center = widget.center ?? LatLng(37.422131, -122.084801);
  }

  void _addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/images/homeIcon.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast(context, "Error", "Location services are disabled.",
          ToastificationType.error);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(context, "Error", "Location permission denied.",
            ToastificationType.error);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToast(
          context,
          "Error",
          "Location permissions are permanently denied, we cannot request permissions.",
          ToastificationType.error);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
      });
      mapController.animateCamera(CameraUpdate.newLatLngZoom(_center!, 16.9));
    } catch (e) {
      showToast(context, "Error", "Error getting location: $e",
          ToastificationType.error);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (widget.center == null) _getUserLocation();
  }

  void checkEnableSave() {
    final phoneValid = RegExp(r'^\d+$').hasMatch(phoneController.text);

    if (!phoneValid && phoneController.text.isNotEmpty) {
      showToast(context, "Error", "Phone number must contain only digits.",
          ToastificationType.error);
    }

    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        phoneValid) {
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
      // Simulate the address saving operation
      try {
        var error = await userService.registerCoordinates({
          'phone': phoneController.text,
          'address': {
            'name': nameController.text,
            'street': addressController.text,
            'latitude': _center.latitude,
            'longitude': _center.longitude,
          }
        });

        if (error == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        } else {
          showToast(context, "Error", error, ToastificationType.error);
          print(error);
        }
      } catch (e) {
        showToast(context, "Error", "Unexpected error occurred, try later.",
            ToastificationType.error);
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
          title: Text('Save Address'),
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: GoogleMap(
                mapType: MapType.terrain,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.center ?? _center,
                  zoom: 16.9,
                ),
                myLocationButtonEnabled: false,
                onTap: (LatLng latLng) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(center: _center),
                    ),
                  );
                },
                markers: {
                  Marker(
                      markerId: MarkerId('_currentLocation'),
                      position: widget.center ?? _center,
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
              maxLines: 10,
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9()]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
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
