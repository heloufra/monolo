// import 'package:flutter/material.dart';
// import 'package:olo/components/continue.dart';
// import 'package:olo/services/clientService.dart';

// class NewddressPage extends StatefulWidget {
//   NewddressPage({super.key});

//   @override
//   State<NewddressPage> createState() => _NewddressPage();
// }

// class _NewddressPage extends State<NewddressPage> {
//   final nameController = TextEditingController();
//   final addressController = TextEditingController();

//   final ClientService clientService = ClientService();
//   bool showError = false;
//   String errorMessage = '';

//   bool enableSave = false;

//   void checkEnableSave() {
//     if (nameController.text.isNotEmpty &&
//         addressController.text.isNotEmpty ) {
//       setState(() {
//         enableSave = true;
//       });
//     } else {
//       setState(() {
//         enableSave = false;
//       });
//     }
//   }

//   void saveAddress() async {
//     if (enableSave) {
//       setState(() {
//         enableSave = false;
//       });
//       var (success, msg) = await clientService.newAddress(nameController.text, addressController.text);

//       if (success) {
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
//   void initState() {
//     super.initState();
//     nameController.addListener(checkEnableSave);
//     addressController.addListener(checkEnableSave);

//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('New Address',
//             style: TextStyle(color: Colors.black, fontSize: 24)),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 200,
//               color: Colors.grey[300],
//               child: Center(
//                 child: Text('Maps need key to work'),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               addressController.text,
//               style: TextStyle(fontSize: 16),
//             ),
//             const Divider(
//               color: Colors.black,
//               thickness: 0.1,
//               indent: 0,
//             ),
//             SizedBox(height: 20),
//             Text('Name', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText:
//                     'Add a name for this address so you can find it easily later.',
//               ),
//             ),
//             SizedBox(height: 16),
//             Text('Address', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'House or apartment number, floor...'),
//               maxLines: 3,
//               minLines: 2,
//             ),
//             SizedBox(height: 16),
//             showError
//                 ? Text(
//                     errorMessage,
//                     style: TextStyle(color: Colors.red),
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       )),
//       bottomNavigationBar: BottomAppBar(
//         height: 110,
//         color: Colors.transparent,
//         child: Continue(
//             onTap: enableSave
//                 ? saveAddress
//                 : null,
//             enable: enableSave,
//             textbutton: 'New Address'),
//         elevation: 0,
//       ),
//     );
//   }
// }
