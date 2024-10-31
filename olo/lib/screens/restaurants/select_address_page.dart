import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:olo/providers/address.dart';


class SelectAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Address'),
        elevation: 0,
      ),
      body: Consumer<AddressProvider>(
        builder: (context, addressProvider, child) {
          if (addressProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (addressProvider.addresses == null || addressProvider.addresses!.isEmpty) {
            return Center(child: Text('No addresses available'));
          }

          return ListView.builder(
            itemCount: addressProvider.addresses!.length,
            itemBuilder: (context, index) {
              final address = addressProvider.addresses![index];
              final isSelected = address == addressProvider.selectedAddress;

              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200]!,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
                  ),
                  title: Text(
                    address.street ?? 'No street available',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                  trailing: isSelected 
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                  onTap: () {
                    addressProvider.selectedAddress = address;
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add address page
          context.go("/profile/address/new");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}