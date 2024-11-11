import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? realeaseDate;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.realeaseDate});
  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    realeaseDate = data['realeaseDate'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      realeaseDate: realeaseDate!,
    );
  }
}
