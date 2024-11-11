import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/song/song_repository.dart';
import 'package:spotify_clone_with_flutter/data/source/song_firebase_service.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }
}
