import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/auth/get_user_usecase.dart';
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
}
