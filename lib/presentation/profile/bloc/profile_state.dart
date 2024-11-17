import 'package:spotify_clone_with_flutter/domain/entities/auth/user.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity userEntity;
  ProfileLoaded({required this.userEntity});
}

class ProfileFailure extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  ProfileUpdateSuccess(this.message);
}

class ProfileUpdateFailure extends ProfileState {
  final String errorMessage;

  ProfileUpdateFailure(this.errorMessage);
}
