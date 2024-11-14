import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';

abstract class FavoriteSongState {}

class FavoriteSongLoading extends FavoriteSongState {}

class FavoriteSongLoaded extends FavoriteSongState {
  final List<SongEntity> favoriteSongs;
  FavoriteSongLoaded({required this.favoriteSongs});
}

class FavoriteSongFailure extends FavoriteSongState {}
