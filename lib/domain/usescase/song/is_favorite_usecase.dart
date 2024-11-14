import 'package:spotify_clone_with_flutter/core/usecase/usecase.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/song/song_repository.dart';
import 'package:spotify_clone_with_flutter/service.dart';

class IsFavoriteUsecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavorite(params!);
  }
}
