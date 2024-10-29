import 'package:spotify_clone_with_flutter/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/data/models/create_user_model.dart';
import 'package:spotify_clone_with_flutter/domain/entities/auth/auth_reponsitory.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class RegisterUsecase implements Usecase<Either, CreateUserModel>{
  @override
  Future<Either> call({CreateUserModel ? params}) async{
    return sl<AuthReponsitory>().register(params!);
  }
}