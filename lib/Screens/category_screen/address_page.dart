import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/address_model.dart';
import '../../provider/profile_provider.dart';
import '../common/colors.dart';

class AddressPage extends StatelessWidget {
  static const routeName = '/address';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Addresses',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // List of Existing Addresses
                Expanded(
                  child: profileProvider.addresses.isEmpty
                      ? Center(
                    child: Text(
                      'No addresses available. Please add a new address.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                      : ListView.builder(
                    itemCount: profileProvider.addresses.length,
                    itemBuilder: (context, index) {
                      final address = profileProvider.addresses[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(address.fullAddress),
                          subtitle: Text(
                              '${address.name}\n${address.mobileNumber}'), // Display name and phone number
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<Address>(
                                value: address,
                                groupValue:
                                profileProvider.selectedAddress,
                                onChanged: (Address? value) {
                                  if (value != null) {
                                    profileProvider.selectAddress(value);
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _confirmDeleteAddress(context, address.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                // Button to Add New Address
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddAddressPage()),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: white,
                  ),
                  label: Text(
                    'Add New Address',
                    style: TextStyle(color: white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Confirms deletion of an address
  void _confirmDeleteAddress(BuildContext context, String addressId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Address'),
        content: Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false)
                  .removeAddress(addressId);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Address deleted successfully.')),
              );
            },
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

/// Add Address Page
class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  String addressLine1 = '';
  String addressLine2 = '';
  String city = '';
  String state = '';
  String zipCode = '';
  String name = ''; // New variable for name
  String phoneNumber = ''; // New variable for phone number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Address',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // New Name Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              // New Phone Number Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Phone Number';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              // Address Line 1
              TextFormField(
                decoration: InputDecoration(labelText: 'Address Line 1'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Address Line 1';
                  }
                  return null;
                },
                onSaved: (value) {
                  addressLine1 = value!;
                },
              ),
              // Address Line 2
              TextFormField(
                decoration: InputDecoration(labelText: 'Address Line 2'),
                onSaved: (value) {
                  addressLine2 = value ?? '';
                },
              ),
              // City
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter City';
                  }
                  return null;
                },
                onSaved: (value) {
                  city = value!;
                },
              ),
              // State
              TextFormField(
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter State';
                  }
                  return null;
                },
                onSaved: (value) {
                  state = value!;
                },
              ),
              // Zip Code
              TextFormField(
                decoration: InputDecoration(labelText: 'Zip Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Zip Code';
                  }
                  return null;
                },
                onSaved: (value) {
                  zipCode = value!;
                },
              ),
              SizedBox(height: 24),
              // Save Button
              ElevatedButton(
                onPressed: _saveAddress,
                child: Text('Save Address', style: TextStyle(color: white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Saves the new address
  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newAddress = Address(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        city: city,
        state: state,
        zipCode: zipCode,
        name: name, // Save name
        mobileNumber: phoneNumber, // Save phone number
      );
      Provider.of<ProfileProvider>(context, listen: false)
          .addAddress(newAddress);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address added successfully.')),
      );
    }
  }
}
