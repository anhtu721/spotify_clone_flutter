import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/get_play_list_usecase.dart';
import 'package:spotify_clone_with_flutter/presentation/home/bloc/playlist/play_list_state.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());
  Future<void> getNewSongs() async {
    var returnedSong = await sl<GetPlayListUsecase>().call();

    returnedSong.fold((l) {
      emit(PlayListLoading());
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
