import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/utlis/toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class NewAddressPage extends StatefulWidget {
  NewAddressPage();

  @override
  State<NewAddressPage> createState() => _CombinedEditAddressPageState();
}

class _CombinedEditAddressPageState extends State<NewAddressPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  bool enableSave = true;
  late Completer<GoogleMapController> mapController;
  static LatLng? _center = null;
  bool _isFullScreenMap = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addCustomIcon();
    nameController.text = '';
    addressController.text = '';
    nameController.addListener(checkEnableSave);
    addressController.addListener(checkEnableSave);
    _getUserLocation();
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
      // mapController.animateCamera(CameraUpdate.newLatLngZoom(_center, 16.9));
    } catch (e) {
      showToast(context, "Error", "Failed to get user location.",
          ToastificationType.error);
    }
  }

  void _addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/images/homeIcon.png")
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    // if (_center == null) _getUserLocation();
    // if (_center != null)
    //   mapController.moveCamera(CameraUpdate.newLatLng(_center as LatLng));
  }

  void checkEnableSave() {
    if (nameController.text.isNotEmpty && addressController.text.isNotEmpty) {
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
    // Danger zone
    if (enableSave) {
      setState(() {
        enableSave = false;
      });
      try {
        final provider = Provider.of<AddressProvider>(context, listen: false);
        final newAddress = {
          'name': nameController.text,
          'street': addressController.text,
          'latitude': _center?.latitude,
          'longitude': _center?.longitude,
        };

        await provider.addAddress(newAddress);
        if (provider.isLoading) {
          setState(() {
            _isLoading = true;
          });
        }
        if (provider.error != null) {
          setState(() {
            _isLoading = false;
          });
          context.go("/profile/address");
        } else {
          setState(() {
            _isLoading = false;
          });
          showToast(
              context, "Error", provider.error!, ToastificationType.error);
        }
      } catch (e) {
        showToast(context, "Error", "Unexpected error occurred, try later.",
            ToastificationType.error);
      }
    }
  }

  void _tapGoogleMaps(LatLng position) {
    _toggleFullScreenMap();
  }

  void _toggleFullScreenMap() {
    print("Toggling full screen map");
    setState(() {
      _isFullScreenMap = !_isFullScreenMap;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(_isFullScreenMap ? 'Mark Entrance' : 'Add New Address'),
        automaticallyImplyLeading: false,
        actions: !_isFullScreenMap
            ? [
                IconButton(
                  icon: Icon(
                    Icons.close, // Use the close (X) icon
                    color: Colors.black, // Set the icon color to black
                    size: 28, // Adjust the size of the icon
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the screen when pressed
                  },
                ),
              ]
            : null,

        elevation: 0, // Remove shadow
      ),
      body: _center == null
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : SafeArea(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Expanded(
                          child: _isFullScreenMap
                              ? _buildFullScreenMap()
                              : _buildSplitScreen(),
                        ),
                      ],
                    ),
            ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        color: Colors.transparent,
        child: Continue(
          onTap: _isFullScreenMap
              ? _toggleFullScreenMap
              : (enableSave ? saveAddress : null),
          enable: true,
          textbutton: _isFullScreenMap ? 'Save' : 'Save Address',
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildFullScreenMap() {
    return GoogleMap(
      mapType: MapType.terrain,
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
      initialCameraPosition: CameraPosition(
        target: _center ?? LatLng(0, 0),
        zoom: 16.9,
      ),
      myLocationEnabled: true,
      compassEnabled: true,
      myLocationButtonEnabled: false,
      markers: {
        Marker(
          markerId: MarkerId('_currentLocation'),
          position: _center ?? LatLng(0, 0),
          icon: markerIcon,
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              _center = newPosition;
            });
          },
        ),
      },
      onCameraMove: (position) {
        setState(() {
          _center = position.target;
        });
      },
    );
  }

  Widget _buildSplitScreen() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: GoogleMap(
            mapType: MapType.terrain,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
            onTap: _tapGoogleMaps,
            initialCameraPosition: CameraPosition(
              target: _center ?? LatLng(0, 0),
              zoom: 16.9,
            ),
            myLocationEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId('_currentLocation'),
                position: _center ?? LatLng(0, 0),
                icon: markerIcon,
                onTap: _toggleFullScreenMap,
              ),
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressController.text,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(color: Colors.black, thickness: 0.1),
                  SizedBox(height: 10),
                  SizedBox(height: 8),
                  // TextField(
                  //   controller: nameController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Add a name for this address',
                  //   ),
                  // ),
                  CustomTextField(
                      controller: nameController,
                      label: 'Name',
                      onChanged: checkEnableSave),
                  SizedBox(height: 16),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: addressController,
                    label: 'Address',
                    onChanged: checkEnableSave,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
