import 'package:get_it/get_it.dart';
import 'package:spotify_clone_with_flutter/data/reponsitory/auth/auth_repository_impl.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/song/song_repository.dart';
import 'package:spotify_clone_with_flutter/data/reponsitory/song/song_repository_impl.dart';
import 'package:spotify_clone_with_flutter/data/source/auth_firebase_service.dart';
import 'package:spotify_clone_with_flutter/domain/reponsitory/auth/auth_repository.dart';
import 'package:spotify_clone_with_flutter/data/source/song_firebase_service.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/auth/get_user_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/auth/register_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/auth/sigin_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/add_or_remove_favorite_songs_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/get_favorite_songs_usercase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/get_new_songs_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/get_play_list_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/is_favorite_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  sl.registerSingleton<RegisterUsecase>(RegisterUsecase());
  sl.registerSingleton<SigInUsecase>(SigInUsecase());
  sl.registerSingleton<GetNewSongsUsecase>(GetNewSongsUsecase());
  sl.registerSingleton<GetPlayListUsecase>(GetPlayListUsecase());
  sl.registerSingleton<AddOrRemoveFavoriteSongsUsecase>(AddOrRemoveFavoriteSongsUsecase());
  sl.registerSingleton<IsFavoriteUsecase>(IsFavoriteUsecase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());  
  sl.registerSingleton<GetFavoriteSongsUsercase>(GetFavoriteSongsUsercase());

}
