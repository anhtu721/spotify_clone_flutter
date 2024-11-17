import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/data/models/user_model.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/auth/get_user_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/auth/update_user_usecase.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/profile_state.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  Future<void> getUser() async {
    try {
      var user = await sl<GetUserUsecase>().call();
      user.fold(
        (l) {
          emit(ProfileFailure());
        },
        (userEntity) {
          emit(ProfileLoaded(userEntity: userEntity));
        },
      );
    } catch (e) {
      emit(ProfileFailure());
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      emit(ProfileUpdating());
      var result = await sl<UpdateUserUsecase>()
          .call(params: userModel); // Truyền userModel vào đây

      result.fold(
        (l) {
          emit(ProfileUpdateFailure(l));
        },
        (r) {
          emit(ProfileUpdateSuccess('User updated successfully!'));
          getUser();
        },
      );
    } catch (e) {
      emit(ProfileUpdateFailure('An error occurred while updating.'));
    }
  }
}
