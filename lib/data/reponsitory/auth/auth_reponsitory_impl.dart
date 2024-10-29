import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/data/models/create_user_model.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';
import 'package:spotify_clone_with_flutter/data/source/auth_firebase_service.dart';
import 'package:spotify_clone_with_flutter/domain/entities/auth/auth_reponsitory.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class AuthReponsitoryImpl extends AuthReponsitory {
  @override
  Future<Either> signin(SiginUserModel signinUserModel) async {
    return await sl<AuthFirebaseService>().signin(signinUserModel);
  }

  @override
  Future<Either> register(CreateUserModel createUser) async {
    return await sl<AuthFirebaseService>().register(createUser);

  }
}
