import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<String?> pickImage(BuildContext context) async {
    final picker = ImagePicker();

    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick an image source'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: const Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: const Text('Camera'),
              ),
            ],
          )
        ],
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        return pickedFile.path;
      }
    }
    return null;
  }
}
