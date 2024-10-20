import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/widgets/CustomAlertDialog.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressProvider>(context, listen: false)
          .fetchAddressesIfNeeded();
    });
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, AddressProvider provider, String addressId) async {
    // Usage example:
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Confirm Deletion",
          content: "Are you sure you want to delete this address?",
          confirmButtonText: "Confirm",
          onCancel: () {
            Navigator.of(context).pop();
          },
          onConfirm: () async {
            // Perform the action (delete account or log out)
            Navigator.of(context).pop();
            await _deleteAddress(context, provider, addressId);
          },
        );
      },
    );

    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       backgroundColor: Colors.white,
    //       title: Text('Confirm Deletion'),
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: <Widget>[
    //             Text('Are you sure you want to delete this address?'),
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('Cancel', style: TextStyle(color: Colors.black)),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         TextButton(
    //           child: Text('Delete', style: TextStyle(color: Colors.black)),
    //           onPressed: () async {
    //             Navigator.of(context).pop();
    //             await _deleteAddress(context, provider, addressId);
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  Future<void> _deleteAddress(
      BuildContext context, AddressProvider provider, String addressId) async {
    await provider.deleteAddress(addressId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Address', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
                  } else if (provider.addresses == null ||
                      provider.addresses!.isEmpty) {
                    return Center(child: Text('No addresses available'));
                  } else {
                    return ListView.builder(
                      itemCount: provider.addresses!.length +
                          1, // +1 for "Add New Address"
                      itemBuilder: (context, index) {
                        if (index < provider.addresses!.length) {
                          final address = provider.addresses![index];
                          return Dismissible(
                            key: Key(address.id.toString()),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              await _showDeleteConfirmationDialog(
                                  context, provider, address.id);
                              return false; // We handle the deletion manually, so always return false
                            },
                            child: Card(
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: 12),
                              shadowColor: Colors.white,
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: Colors.grey.shade200, width: 1),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text(
                                    address.name ?? "Address not available"),
                                subtitle: Text(address.street ?? ""),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () {
                                  GoRouter.of(context).go(
                                      '/profile/address/edit',
                                      extra: address);
                                  Provider.of<AddressProvider>(context,
                                          listen: false)
                                      .fetchAddressesIfNeeded();
                                },
                              ),
                            ),
                          );
                        } else {
                          return Card(
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 16),
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.add),
                              title: Text("Add New Address"),
                              onTap: () {
                                GoRouter.of(context).go('/profile/address/new');
                                Provider.of<AddressProvider>(context,
                                        listen: false)
                                    .fetchAddressesIfNeeded();
                              },
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
