import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/song/song_repository.dart';
import 'package:spotify_clone_with_flutter/data/source/song_firebase_service.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songID) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songID);
  }

  @override
  Future<bool> isFavorite(String songID) async {
    return await sl<SongFirebaseService>().isFavorite(songID);
  }

  @override
  Future<Either> getFavoriteSong() async {
    return await sl<SongFirebaseService>().getFavoriteSong();
  }
}
