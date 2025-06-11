import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_colors.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }

  }

  void _showImagePickerOptions() {
    print("fun call");
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Select from Camera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Select from Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _showImagePickerOptions,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : AssetImage('assets/Placeholder_image/place_holder_iamge.jpg') as ImageProvider,
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary_main,
                child: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
