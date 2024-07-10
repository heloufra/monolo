

class User {
  final String name;
  final String email;
  final String phone;
  // final List<String> addresses;
  // final String dataConsent;
  final bool notified;
  final String notifiedMedia;


  User({required this.name, required this.email, required this.phone, required this.notified, required this.notifiedMedia});

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['name']);
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      notified: json['notified'],
      notifiedMedia: json['notifiedMedia'],
      // dataConsent: json['dataConsent'],
      // notified: json['notified'],
      // notifiedMedia: json['notifiedMedia'],
      // addresses: json['addresses'].map((dynamic item) => Address.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': phone,
  };
}