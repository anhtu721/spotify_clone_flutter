import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_with_flutter/data/models/create_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';

abstract class AuthFirebaseService {
  Future<Either> register(CreateUserModel createUserModel);
  Future<Either> signin(SiginUserModel signinUserModel);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SiginUserModel signinUserModel) async {
    try {


      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserModel.email, password: signinUserModel.password);

          
          return const Right('Sign in was successfull.');
    } on FirebaseAuthException catch (e){
      String messageError = '';
      if (e.code == 'invalid-email'){
        messageError = 'Not user found for that email.';
      } 
      else if (e.code == 'invalid-credential')
      {
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
          FirebaseFirestore.instance.collection('Users').add({
            'name': createUserModel.fullName,
            'email': data.user?.email,
          });
          return const Right('Register was successfull.');
    } on FirebaseAuthException catch (e){
      String messageError = '';
      if (e.code == 'weak-password'){
        messageError = 'The password is too weak.';
      } 
      else if (e.code == 'email-already-in-user')
      {
        messageError = 'An account already exists with that email.';
      }
      
      return Left(messageError);
    }
  }
}
