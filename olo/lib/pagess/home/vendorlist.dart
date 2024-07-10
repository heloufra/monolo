import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olo/pagess/settings/profile.dart';
import 'package:olo/services/vendorService.dart';
import 'package:olo/types/Vendor.dart';

// Assume you have your Vendor class here

enum VendorType {
  TYPE1, // Replace with actual types
  TYPE2,
}

enum VendorStatus {
  ACTIVE, // Replace with actual statuses
  INACTIVE,
}

class VendorListPage extends StatelessWidget {
  VendorService vendorService = VendorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Restaurants'),
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Vendor>>(
        future: vendorService.getVendors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No vendors found'));
          } else {
            List<Vendor> vendors = snapshot.data!;
            return ListView.builder(
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                Vendor vendor = vendors[index];
                return VendorCard(vendor: vendor);
              },
            );
          }
        },
      ),
    );
  }
}

class VendorCard extends StatelessWidget {
  final Vendor vendor;

  VendorCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    vendor.picture ?? 'https://via.placeholder.com/150',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 170,
                  child: CircleAvatar(
                    backgroundImage:
                        vendor.logo != null ? NetworkImage(vendor.logo!) : null,
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: vendor.logo == null
                        ? Icon(Icons.restaurant, size: 30)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendor.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  vendor.description ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(
                          'Free Delivery',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                      SizedBox(width: 10),
                      Chip(
                        label: Text(
                          '246 meters',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                      SizedBox(width: 10),
                      Chip(
                        label: Text(
                          '20-35 min',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        backgroundColor: Colors.green.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// class VendorCard extends StatelessWidget {
//   final Vendor vendor;

//   VendorCard({required this.vendor});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(vendor.picture ?? 'https://via.placeholder.com/150'),
//           ListTile(
//             leading: vendor.logo != null
//                 ? Image.network(vendor.logo!)
//                 : Icon(Icons.restaurant),
//             title: Text(vendor.name),
//             subtitle: Text(vendor.description ?? ''),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Free Delivery', style: TextStyle(color: Colors.green)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('${vendor.address[0].city} meters', style: TextStyle(color: Colors.grey)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('20-35 min', style: TextStyle(color: Colors.grey)),
//           ),
//         ],
//       ),
//     );
//   }
// }

