class Address {
  final String id;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String name; // New field for the name
  final String mobileNumber; // New field for the phone number

  Address({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.name, // Add to constructor
    required this.mobileNumber, // Add to constructor
  });

  String get fullAddress {
    return '$addressLine1, $addressLine2, $city, $state, $zipCode';
  }
}
