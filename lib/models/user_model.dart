class UserModel {
  int? userId;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  List<String>? addresses;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.addresses,
  });

 // Convierte el objeto UserModel a Map para poder guardarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
   'first_name': firstName, 
      'last_name': lastName, 
      'date_of_birth': dateOfBirth?.toIso8601String(), 
    };
  }
factory UserModel.fromMap(Map<String, dynamic> map) {
  return UserModel(
    userId: map['_id'],
    firstName: map['first_name'], 
    lastName: map['last_name'],
    dateOfBirth: map['date_of_birth'] != null
        ? DateTime.tryParse(map['date_of_birth'] as String) 
        : null, 
  );
}
  
  // ...otros métodos y lógica...
}


class Address {
  final int id;
  final int userId; // este campo es para relacionar la dirección con un usuario
  final String street;
  final String city;
  final String country;
  final String zipCode;

  Address({
    required this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.country,
    required this.zipCode,
  });

Map<String, dynamic> toMap() {
  return {
    'userId': userId,
    'street': street,
    'city': city,
    'country': country,
    'zipCode': zipCode,
  };
}

 factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['addressId'], 
      userId: map['userId'], 
      street: map['street'],
      city: map['city'], 
      country: map['country'], 
      zipCode: map['zipCode'], 
    );
  }
}

