import 'package:flutter/material.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/screens/profile/address/editaddress.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    // Fetch addresses when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressProvider>(context, listen: false).fetchAddressesIfNeeded();
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
              child: Consumer<AddressProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (provider.error != null) {
                    return Center(child: Text('Error: ${provider.error}'));
                  } else if (provider.addresses == null || provider.addresses!.isEmpty) {
                    return Center(child: Text('No addresses available'));
                  } else {
                    return ListView.builder(
                      itemCount: provider.addresses!.length,
                      itemBuilder: (context, index) {
                        final address = provider.addresses![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(address.street ?? "Address not available"),
                            subtitle: Text(address.name),
                            trailing: Icon(Icons.arrow_forward_ios),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => EditAddressPage(address: address),
                              //   ),
                              // ).then((_) {
                              //   // Refresh the address list after editing an address
                              //   Provider.of<AddressProvider>(context, listen: false).fetchAddressesIfNeeded();
                              // });
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // Uncomment this to add a new address using the FloatingActionButton
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add address functionality here
      //   },
      //   child: Icon(Icons.add),
      //   splashColor: Colors.white,
      //   backgroundColor: Colors.white,
      // ),
    );
  }
}
