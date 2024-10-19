import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/screens/profile/address/markEntranceEdit.dart';
import 'package:provider/provider.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/models/address.dart';
import 'package:olo/utlis/toast.dart';
import 'package:toastification/toastification.dart';

class EditAddressPage extends StatefulWidget {
  final Address address;
  LatLng? center;
  EditAddressPage({required this.address, this.center});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  bool enableSave = true;
  late GoogleMapController mapController;

  late LatLng _center;

  @override
  void initState() {
    super.initState();
    _addCustomIcon();
    nameController.text = widget.address.name;
    addressController.text = widget.address.street ?? '';
    nameController.addListener(checkEnableSave);
    addressController.addListener(checkEnableSave);
    if (widget.center != null) {
      _center = widget.center!;
    } else {
      _center = LatLng(widget.address.latitude ?? 1.1, widget.address.longitude ?? 1.1);
    }
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void checkEnableSave() {
    // if (nameController.text.isNotEmpty &&
    //     addressController.text.isNotEmpty &&
    //     (nameController.text != widget.address.name ||
    //         addressController.text != widget.address.street)) {
    //   setState(() {
    //     enableSave = true;
    //   });
    // } else {
    //   setState(() {
    //     enableSave = false;
    //   });
    // }
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
        title: Text('Edit Address'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                    target: _center,
                    zoom: 16.9,
                  ),
                  myLocationButtonEnabled: false,
                  onTap: (LatLng latLng) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Markentranceedit(center: latLng, address: widget.address);
                    })).then((value) {
                      if (value != null) {
                        setState(() {
                          _center = value;
                        });
                      }
                    });
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('_currentLocation'),
                      position: _center,
                      icon: markerIcon,
                      draggable: true,
                      onDragEnd: ((newPosition) {
                        setState(() {
                          _center = newPosition;
                        });
                      }),
                    ),
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
            ],
          ),
        ),
      ),
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
