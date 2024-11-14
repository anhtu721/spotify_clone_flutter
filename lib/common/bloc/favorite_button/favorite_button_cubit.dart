import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/add_or_remove_favorite_songs_usecase.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInit());

  Future<void> favoriteButtonUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavoriteSongsUsecase>().call(params: songId);
    result.fold(
      (l) {},
      (isFavorite) {
        emit(FavoriteButtonUpdate(isFavorite: isFavorite));
      },
    );
  }
}
