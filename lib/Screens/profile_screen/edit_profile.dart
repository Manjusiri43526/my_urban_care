import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_urban_care/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_urban_care/Screens/common/colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers to manage input fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _numberController;

  // Variable to hold the selected image
  File? _selectedImage;

  // ImagePicker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _numberController = TextEditingController(text: profile.number);
    _addressController = TextEditingController(text: profile.address);
    _selectedImage = profile.profileImage;
  }

  // Function to show the selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image From:'),
          content: const Text('Choose the image source for your profile photo.'),
          actions: [
            TextButton(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to pick image from specified source
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: source, imageQuality: 80);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle any errors here
      print('Error picking image: $e');
    }
  }

  // Function to save profile changes
  void _saveProfile() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String address = _addressController.text.trim();

    if (name.isEmpty || email.isEmpty || address.isEmpty) {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    // Update the profile in the provider
    Provider.of<ProfileProvider>(context, listen: false).updateProfile(
      name: name,
      email: email,
      address: address,
      profileImage: _selectedImage,
    );

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Saved'),
          content: const Text('Your profile has been updated successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 24, color: white),
        ),
        backgroundColor: primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
        child: Column(
          children: [
            // Profile Photo Section
            GestureDetector(
              onTap: _showImageSourceDialog, // Show dialog on tap
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: primary.withOpacity(0.2),
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const AssetImage("assets/images/profile_photo.jpg") as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name Input
            _buildTextField(
              label: "Name",
              controller: _nameController,
            ),

            const SizedBox(height: 16),

            // Email Input
            _buildTextField(
              label: "Email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(
              height: 16,
            ),

            _buildTextField(
              label: "Mobile Number",
              controller: _numberController,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            // Address Input
            _buildTextField(
              label: "Address",
              controller: _addressController,
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "Enter your $label",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose controllers when not needed
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
