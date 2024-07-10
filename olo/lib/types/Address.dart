class Address {
  final String id;
  final String address;
  final String name;
  final String zip;
  final String country;
  final String city;

  Address({required this.id, required this.address, required this.name, required this.zip, required this.country, required this.city});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      zip: json['zip'],
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'zip': zip,
      'country': country,
      'city': city,
    };
  }
  
}