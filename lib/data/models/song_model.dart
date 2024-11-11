import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate; // Đã sửa lỗi chính tả ở đây

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'] ?? '';  // Cung cấp giá trị mặc định nếu null
    artist = data['artist'] ?? '';  // Cung cấp giá trị mặc định nếu null
    duration = data['duration'] ?? 0;  // Cung cấp giá trị mặc định nếu null
    releaseDate = data['releaseDate'] ?? Timestamp.fromMillisecondsSinceEpoch(0); // Cung cấp giá trị mặc định nếu null
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    // Kiểm tra null trước khi sử dụng toán tử `!` để tránh lỗi
    return SongEntity(
      title: title ?? '',  // Cung cấp giá trị mặc định nếu title là null
      artist: artist ?? '',  // Cung cấp giá trị mặc định nếu artist là null
      duration: duration ?? 0,  // Cung cấp giá trị mặc định nếu duration là null
      releaseDate: releaseDate ?? Timestamp.fromMillisecondsSinceEpoch(0),  // Cung cấp giá trị mặc định nếu releaseDate là null
    );
  }
}
