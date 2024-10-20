// build a policy screee

import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          '''
Privacy Policy for OLO App


1. Information We Collect:
   1.1 Personal Information: We may collect, store, and process various categories of personal information, including but not limited to your name, email address, telephone number, and any other information you provide to us voluntarily.
   1.2 Delivery Information: In order to facilitate the delivery of your orders, we collect and store delivery addresses and any specific delivery instructions you may provide.
   1.3 Payment Information: To process your payments, we may collect and store payment card details, bank account information, or other payment method data as applicable.
   1.4 Location Data: Subject to your express permission and consent, we may collect and process data pertaining to your geographical location.
   1.5 Order History: We maintain records of your order history, including items ordered, order frequency, and preferences.

2. Utilization of Your Information:
   2.1 Order Processing and Delivery: Your information is utilized to process, fulfill, and deliver your orders efficiently and accurately.
   2.2 Service Enhancement: We analyze user data to improve and optimize our services, user interface, and overall app performance.
   2.3 Communication: Your contact information may be used to communicate important updates about your orders, our services, and promotional offers (subject to your consent where required by law).
   2.4 Personalization: We may use your data to tailor and personalize your app experience, including recommendations and custom offers.
   2.5 Artificial Intelligence Training: We may utilize the collected data to train artificial intelligence models aimed at enhancing user experience, improving service efficiency, and developing new features. This process involves anonymizing and aggregating data to protect individual privacy.

3. Data Sharing and Disclosure:
   We may share your information with the following categories of recipients:
   3.1 Affiliated Restaurants: To facilitate order fulfillment and preparation.
   3.2 Delivery Partners: To enable successful delivery of your orders.
   3.3 Payment Processors: To handle and process financial transactions securely.
   3.4 Service Providers: We may engage third-party service providers to perform functions on our behalf, subject to obligations consistent with this Privacy Policy and any other appropriate confidentiality and security measures.

4. Data Security Measures:
   We implement and maintain appropriate technical, administrative, and physical security measures designed to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, please note that no method of transmission over the Internet or method of electronic storage is 100% secure.

5. Your Rights and Choices:
   5.1 Access: You have the right to request access to the personal information we hold about you.
   5.2 Correction: You may request correction of your personal information where it is inaccurate or incomplete.
   5.3 Deletion: In certain circumstances, you may request the deletion of your personal information.
   5.4 Objection: You have the right to object to certain processing of your personal information.
   5.5 Data Portability: Where technically feasible, you may request a copy of your personal information in a structured, commonly used, and machine-readable format.

6. Changes to This Policy:
   We reserve the right to modify this Privacy Policy at any time. Any changes will be effective immediately upon posting of the revised Privacy Policy. We encourage you to review this Privacy Policy periodically to stay informed about how we collect, use, and protect your information.

7. Contact Information:
   If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at:

   [Your Contact Information]

By using our app, you acknowledge that you have read and understood this Privacy Policy and agree to the collection, use, and disclosure of your information as described herein.

Last updated: 20/10/2024
            ''',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
