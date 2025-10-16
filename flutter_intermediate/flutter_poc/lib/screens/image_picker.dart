import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_poc/widgets/app_layout.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({super.key});

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File? image;
  final imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      setState(() {});
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      image = File(pickedImage.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            image == null ? Text('no image picked') : Image.file(image!),
            const Spacer(), // pushes button to bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: pickImageFromCamera,
                  child: Icon(Icons.camera_alt_outlined),
                ),
                ElevatedButton(
                  onPressed: pickImageFromGallery,
                  child: Icon(Icons.image_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
