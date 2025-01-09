import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_urban_care/model/profile.dart';

import '../model/address_model.dart';


class ProfileProvider with ChangeNotifier {
  List<Address> _addresses = [];
  Address? _selectedAddress;

  List<Address> get addresses => _addresses;
  Address? get selectedAddress => _selectedAddress;

  void addAddress(Address address) {
    _addresses.add(address);
    // If it's the first address, select it by default
    if (_addresses.length == 1) {
      _selectedAddress = address;
    }
    notifyListeners();
  }

  void removeAddress(String id) {
    _addresses.removeWhere((address) => address.id == id);
    // If the removed address was selected, clear selection or select another
    if (_selectedAddress != null && _selectedAddress!.id == id) {
      if (_addresses.isNotEmpty) {
        _selectedAddress = _addresses.first;
      } else {
        _selectedAddress = null;
      }
    }
    notifyListeners();
  }

  void selectAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }


  Profile _profile = Profile(
    name: "John Doe",
    email: "john.doe@example.com",
    address: "123 Main St, Springfield, USA",
    profileImage: null,
    number: '9955444332', // Initially no image
  );

  Profile get profile => _profile;

  void updateProfile({
    String? name,
    String? email,
    String? address,
    File? profileImage,
  }) {
    if (name != null) _profile.name = name;
    if (email != null) _profile.email = email;
    if (address != null) _profile.address = address;
    if (profileImage != null) _profile.profileImage = profileImage;
    notifyListeners();
  }

  void setProfileImage(File image) {
    _profile.profileImage = image;
    notifyListeners();
  }

  void clearProfile() {
    _profile = Profile(
      name: "John Doe",
      email: "john.doe@example.com",
      address: "123 Main St, Springfield, USA",
      profileImage: null,
      number: '9955444332',
    );
    notifyListeners();
  }
}
