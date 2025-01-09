import 'dart:io';

class Profile {
  String name;
  String email;
  String address;
  String number;
  File? profileImage;


  Profile({
    required this.name,
    required this.email,
    required this.number,
    required this.address,
    this.profileImage,
  });
}
