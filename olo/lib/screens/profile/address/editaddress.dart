// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:olo/components/continue.dart';
// import 'package:olo/services/clientService.dart';
// import 'package:olo/types/Address.dart';

// class EditAddressPage extends StatefulWidget {
//   final Address address;

//   EditAddressPage({required this.address}) {}

//   @override
//   State<EditAddressPage> createState() => _EditAddressPageState();
// }

// class _EditAddressPageState extends State<EditAddressPage> {
//   Future<Address>? oddress;

//   bool enableSave = false;

//   bool showError = false;

//   String errorMessage = '';

//   final TextEditingController addressController = TextEditingController();
//   final ClientService clientService = ClientService();


//   _EditAddressPageState() {
//      oddress = getAddress();
//   }

//   @override
//   void initState() {
//     super.initState();
//     oddress = getAddress();
//     addressController.text = widget.address.address;
//   }

//   Future<Address> getAddress() async {
//     return await widget.address;
//   }

//   void checkEnableSave() {
//     if (addressController.text.isNotEmpty &&
//         addressController.text != widget.address.address) {
//       setState(() {
//         enableSave = true;
//       });
//     } else {
//       setState(() {
//         enableSave = false;
//       });
//     }
//   }

//   Future<void> saveAddress() async {
//     if (enableSave) {
//       var (suc, msg) = await clientService.updateAddress(
//           widget.address.id, widget.address.name, addressController.text);

//       if (suc) {
//         Navigator.pop(context, true);
//       } else {
//         setState(() {
//           showError = true;
//           errorMessage = msg;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text('Edit Address'),
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//         body: FutureBuilder<Address>(
//             future: oddress,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   return Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 200,
//                           color: Colors.grey[300],
//                           child: Center(
//                             child: Text('Map Placeholder'),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           addressController.text,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 20),
//                         Text('Address', style: TextStyle(fontSize: 16)),
//                         SizedBox(height: 8),
//                         TextField(
//                           controller: addressController,
//                           maxLines: 2,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (value) => checkEnableSave(),
//                         ),
//                         showError
//                             ? Text(
//                                 errorMessage,
//                                 style: TextStyle(color: Colors.red),
//                               )
//                             : SizedBox(),
//                         SizedBox(height: 16),
//                         Spacer(),
//                       ],
//                     ),
//                   );
//                 }
//               }
//             }),

//         bottomNavigationBar: BottomAppBar(
//           height: 110,
//           color: Colors.transparent,
//           child: Continue(
//               onTap: enableSave
//                   ? saveAddress
//                   : null,
//               enable: enableSave,
//               textbutton: 'Save'),
//           elevation: 0,
//         ),
//         );
//   }
// }
