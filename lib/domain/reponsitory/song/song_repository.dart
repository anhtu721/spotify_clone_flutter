import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songID);
  Future<bool> isFavorite(String songID);
  Future<Either> getFavoriteSong();
}
