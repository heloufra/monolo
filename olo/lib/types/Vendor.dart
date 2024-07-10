

class Vendor {
  String id;
  VendorType type;
  VendorStatus status;
  String name;
  String email;
  String? password;
  String phone;
  String? description;
  String? picture;
  List<Address> address;
  String? logo;


  Vendor({
    required this.id,
    required this.type,
    required this.status,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    this.description,
    this.picture,
    required this.address,
    this.logo,
  });

  // Add methods to serialize/deserialize if necessary
  factory Vendor.fromJson(Map<String, dynamic> json) {

    return Vendor(
      id: json['id'],
      type: VendorType.RESTAURANT,
      status: VendorStatus.WORKINGTAKEAWAY,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      description: json['description'],
      picture: json['picture'],
      address: (json['address'] as List)
          .map((addressJson) => Address.fromJson(addressJson))
          .toList(),
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'status': status.index,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'description': description,
      'picture': picture,
      'address': address.map((addr) => addr.toJson()).toList(),
    };
  }
}

enum VendorType {
  RESTAURANT, // Replace with actual types
}

enum VendorStatus {
 WORKINGTAKEAWAY,
  WORKINGDELIVERY,
  CLOSED
}

class Address {
  String id;
  String city;
  // Add other fields and constructor

  Address({required this.id, required this.city});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
    };
  }
}

class Order {
  String id;
  // Add other fields and constructor

  Order({required this.id});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      // Parse other fields
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // Serialize other fields
    };
  }
}

class Product {
  String id;
  // Add other fields and constructor

  Product({required this.id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      // Parse other fields
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // Serialize other fields
    };
  }
}
