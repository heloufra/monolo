import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/providers/address.dart';
import 'package:provider/provider.dart';

class AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, child) {
        if (addressProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (addressProvider.addresses == null || addressProvider.addresses!.isEmpty) {
          return const Text('No address available');
        }

        final address = addressProvider.addresses!.first;

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200]!,
                width: 1.0,
              ),
            ),
            color: Colors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                  context.go("/profile/address/select");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align to top for multiline text
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0), // Adjust icon alignment
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 24,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        address.street ?? 'No street available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                        maxLines: 2, // Allow up to 2 lines
                        overflow: TextOverflow.ellipsis, // Add ... at the end if text is too long
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0), // Adjust icon alignment
                      child: Icon(
                        Icons.chevron_right,
                        size: 24,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}