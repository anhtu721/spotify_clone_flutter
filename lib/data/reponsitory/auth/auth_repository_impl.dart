import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/data/models/create_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/user_model.dart';
import 'package:spotify_clone_with_flutter/data/source/auth_firebase_service.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/auth/auth_repository.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SiginUserModel signInUser) async {
    return await sl<AuthFirebaseService>().signin(signInUser);
  }

  @override
  Future<Either> register(CreateUserModel createUser) async {
    return await sl<AuthFirebaseService>().register(createUser);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either> updateUser(UserModel updateUser) async {
    return await sl<AuthFirebaseService>().updateUser(updateUser);
  }
}
