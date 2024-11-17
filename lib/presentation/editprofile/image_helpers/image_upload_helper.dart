import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadHelper {
  static Future<String> uploadImage(
      String imagePath, String? oldImageUrl) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    File imageFile = File(imagePath);

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser?.uid ?? '';

    if (uid.isEmpty) {
      throw 'User UID is not available';
    }

    try {
      if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
        try {
          final oldImageRef = storage.refFromURL(oldImageUrl);
          await oldImageRef.delete();
        } catch (e) {
          // ignore: avoid_print
          print("Error deleting old image: $e");
        }
      }

      String fileName = '$uid.jpg';
      Reference reference = storage.ref().child('profile_images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Error uploading image: $e';
    }
  }
}
