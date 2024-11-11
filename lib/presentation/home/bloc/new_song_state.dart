import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';

abstract class NewSongsState {}

class NewSongsLoading extends NewSongsState {}

class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;
  NewSongsLoaded({required this.songs});
}

class NewSongsLoadFail extends NewSongsState {}
