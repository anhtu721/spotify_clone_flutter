import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/get_favorite_songs_usercase.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/favorite_song_state.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class FavoriteSongCubit extends Cubit<FavoriteSongState> {
  FavoriteSongCubit() : super(FavoriteSongLoading());
  
  List<SongEntity> favoriteSongs =[];
  Future<void> getFavoriteSong() async{
    var result = await sl<GetFavoriteSongsUsercase>().call();
    result.fold((l) {
      emit(FavoriteSongFailure());
    }, (r) {
      favoriteSongs = r;
      emit(FavoriteSongLoaded(favoriteSongs: favoriteSongs));
    },);
  }
  void removeSong(int index){
    favoriteSongs.removeAt(index);
    emit(FavoriteSongLoaded(favoriteSongs: favoriteSongs));
    
  }
}
