import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/core/usecase/usecase.dart';
import 'package:spotify_clone_with_flutter/data/models/user_model.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/auth/auth_repository.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class UpdateUserUsecase implements Usecase<Either, UserModel>{
  @override
  Future<Either> call({UserModel ? params}) async{
    return sl<AuthRepository>().updateUser(params!);
  }
}