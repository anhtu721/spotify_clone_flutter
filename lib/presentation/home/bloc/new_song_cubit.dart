import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/get_new_songs_usecase.dart';
import 'package:spotify_clone_with_flutter/presentation/home/bloc/new_song_state.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class NewSongCubit extends Cubit<NewSongsState> {
  NewSongCubit() : super(NewSongsLoading());
  Future<void> getNewSongs() async {
    var returnedSong = await sl<GetNewSongsUsecase>().call();

    returnedSong.fold((l) {
      emit(NewSongsLoadFail());
    }, (data) {
      emit(NewSongsLoaded(songs: data));
    });
  }
}
