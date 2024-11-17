import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_with_flutter/core/configs/constants/app_urls.dart';
import 'package:spotify_clone_with_flutter/data/models/create_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/user_model.dart';
import 'package:spotify_clone_with_flutter/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> register(CreateUserModel createUserModel);
  Future<Either> signin(SiginUserModel signinUserModel);
  Future<Either> getUser();
  Future<Either> updateUser(UserModel userModel);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SiginUserModel signinUserModel) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserModel.email, password: signinUserModel.password);

      return const Right('Sign in was successfull.');
    } on FirebaseAuthException catch (e) {
      String messageError = '';
      if (e.code == 'invalid-email') {
        messageError = 'Not user found for that email.';
      } else if (e.code == 'invalid-credential') {
        messageError = 'Email or password is not correct. Try again.';
      }

      return Left(messageError);
    }
  }

  @override
  Future<Either> register(CreateUserModel createUserModel) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserModel.email, password: createUserModel.password);
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'fullName': createUserModel.fullName,
        'email': data.user?.email,
      });
      return const Right('Register was successfull.');
    } on FirebaseAuthException catch (e) {
      String messageError = '';
      if (e.code == 'weak-password') {
        messageError = 'The password is too weak.';
      } else if (e.code == 'email-already-in-user') {
        messageError = 'An account already exists with that email.';
      }

      return Left(messageError);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.personImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<Either> updateUser(UserModel userModel) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final userId = firebaseAuth.currentUser?.uid;
      if (userId == null) {
        return const Left('User is not logged in');
      }

      String? updatedImageUrl = userModel.imageURL ?? AppUrls.personImage;

      Map<String, dynamic> updatedData = {
        'fullName': userModel.fullName,
        'email': userModel.email,
        'imageURL': updatedImageUrl,
      };
      await firebaseFirestore
          .collection('Users')
          .doc(userId)
          .update(updatedData);

      if (userModel.imageURL != null && userModel.imageURL!.isNotEmpty) {
        await firebaseAuth.currentUser?.updatePhotoURL(userModel.imageURL);
      }
      return const Right('User information updated successfully.');
    } catch (e) {
      return Left('An error occurred while updating user: $e');
    }
  }
}
