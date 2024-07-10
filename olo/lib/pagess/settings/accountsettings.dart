import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(text: "Khalid Fadil");
  final TextEditingController emailController = TextEditingController(text: "khalidfadil@icloud.com");
  final TextEditingController phoneController = TextEditingController(text: "616711333");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Full Name',
              ),
            ),
            SizedBox(height: 16),
            Text('Email', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            Text('Phone number', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 80,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: '+212',
                    items: ['+212'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle phone code change
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone number',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save action
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
