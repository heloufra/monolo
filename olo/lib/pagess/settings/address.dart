import 'package:flutter/material.dart';
import 'package:olo/pagess/settings/editaddress.dart';
import 'package:olo/pagess/settings/newAddress.dart';
import 'package:olo/services/clientService.dart';
import 'package:olo/types/Address.dart';

class AddressPage extends StatefulWidget {
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Address> addresses = [];

  Future<List<Address>> _getAddress() async {
    addresses = await ClientService().getAddress();
    return addresses;
  }

  void _addAddress() {
    // Navigate to the add address page or show a dialog to add address
    // For this example, we'll navigate to the EditAddressPage without an address
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewddressPage(), // Pass an empty Address object
      ),
    ).then((_) {
      // Refresh the address list after adding a new address
      setState(() {
        _getAddress();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Address'),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Address>>(
                future: _getAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(snapshot.data![index].address),
                              subtitle: Text(snapshot.data![index].name),
                                                          trailing: Icon(Icons.arrow_forward_ios),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade200, width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditAddressPage(
                                      address: snapshot.data![index],
                                    ),
                                  ),
                                ).then((_) {
                                  // Refresh the address list after editing an address
                                  setState(() {
                                    _getAddress();
                                  });
                                });
                              },
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAddress,
        child: Icon(Icons.add),
        splashColor: Colors.white,
        backgroundColor: Colors.white,
      ),
    );
  }
}
