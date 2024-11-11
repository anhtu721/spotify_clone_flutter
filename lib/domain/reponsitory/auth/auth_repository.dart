import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/data/models/create_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';

abstract class AuthRepository {

Future<Either> register(
    CreateUserModel createUser,
  );
  Future<Either> signin(
    SiginUserModel signInUser,
  );
  
}