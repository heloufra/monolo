import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/models/address.dart';
import 'package:olo/utlis/toast.dart';
import 'package:toastification/toastification.dart';

class EditAddressPage extends StatefulWidget {
  final Address address;
  final LatLng? initialCenter;

  EditAddressPage({required this.address, this.initialCenter});

  @override
  State<EditAddressPage> createState() =>
      _CombinedEditAddressPageState();
}

class _CombinedEditAddressPageState extends State<EditAddressPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  bool enableSave = true;
  late GoogleMapController mapController;
  late LatLng _center;
  bool _isFullScreenMap = false;

  @override
  void initState() {
    super.initState();
    _addCustomIcon();
    nameController.text = widget.address.name;
    addressController.text = widget.address.street ?? '';
    nameController.addListener(checkEnableSave);
    addressController.addListener(checkEnableSave);
    _center = widget.initialCenter ??
        LatLng(widget.address.latitude ?? 1.1, widget.address.longitude ?? 1.1);
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
    mapController = controller;
  }

  void checkEnableSave() {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        (nameController.text != widget.address.name ||
            addressController.text != widget.address.street)) {
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
      try {
        final provider = Provider.of<AddressProvider>(context, listen: false);
        final updatedAddressData = {
          'id': widget.address.id,
          'name': nameController.text,
          'street': addressController.text,
          'latitude': _center.latitude,
          'longitude': _center.longitude,
        };

        await provider.updateAddress(updatedAddressData, widget.address.id);

        if (provider.error == null) {
          context.go("/profile/address");
        } else {
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
    print("Tapped on Google Maps at $position");

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
        title: Text(_isFullScreenMap ? 'Mark Entrance' : 'Edit Address'),
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
      body: SafeArea(
        child: Column(
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
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 16.9,
      ),
      myLocationButtonEnabled: false,
      markers: {
        Marker(
          markerId: MarkerId('_currentLocation'),
          position: _center,
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
            onMapCreated: _onMapCreated,
            onTap: _tapGoogleMaps,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.9,
            ),
            myLocationButtonEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId('_currentLocation'),
                position: _center,
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
                  CustomTextField(controller: nameController,
                      label: 'Name', onChanged: checkEnableSave),
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
