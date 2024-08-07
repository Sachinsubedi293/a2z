import 'dart:io';
import 'package:a2zjewelry/core/utils/env_components.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  final String? initialImage; // URL or path of the initial image
  final void Function(File) onImagePicked; // Callback for when an image is picked
  final bool edit; // Edit mode flag

  const ProfileImage({
    super.key,
    this.initialImage,
    required this.onImagePicked,
    required this.edit,
  });

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _imageFile; // Local file for the picked image
  final ImagePicker _picker = ImagePicker(); 
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.initialImage != null) {
      _imageUrl = widget.initialImage!;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = null; 
      });
      widget.onImagePicked(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (widget.edit) {
            _pickImage();
          }
        },
        child: CircleAvatar(
          radius: 60,
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!) as ImageProvider
              : widget.initialImage != null
                  ? NetworkImage(baseUrl+_imageUrl!) 
                  : const AssetImage('lib/assets/welcome1.png') as ImageProvider,
          backgroundColor: Colors.grey[200],
          child: (_imageFile == null && widget.initialImage == null)
              ? const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 30,
                )
              : null,
        ),
      ),
    );
  }
}

class ProfileActions extends StatelessWidget {
  final Future<void> Function(BuildContext) onSave;
  final VoidCallback onCancel;

  const ProfileActions({super.key, 
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        ElevatedButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => onSave(context),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
