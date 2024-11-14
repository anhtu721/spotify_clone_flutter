import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  PlayListLoaded({required this.songs});
}

class PlayListLoadFail extends PlayListState {}
