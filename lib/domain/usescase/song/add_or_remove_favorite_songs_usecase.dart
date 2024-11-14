import 'package:spotify_clone_with_flutter/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/song/song_repository.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class AddOrRemoveFavoriteSongsUsecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
