import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/core/usecase/usecase.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';
import 'package:spotify_clone_with_flutter/domain/entities/auth/auth_reponsitory.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class SigInUsecase implements Usecase<Either, SiginUserModel>{
  @override
  Future<Either> call({SiginUserModel ? params}) async{
    return sl<AuthReponsitory>().signin(params!);
  }
}