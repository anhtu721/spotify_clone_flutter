import 'package:get_it/get_it.dart';
import 'package:spotify_clone_with_flutter/data/models/sigin_user_model.dart';
import 'package:spotify_clone_with_flutter/data/reponsitory/auth/auth_reponsitory_impl.dart';
import 'package:spotify_clone_with_flutter/data/source/auth_firebase_service.dart';
import 'package:spotify_clone_with_flutter/domain/entities/auth/auth_reponsitory.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/register_usecase.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/sigin_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthReponsitory>(AuthReponsitoryImpl());
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase());
  sl.registerSingleton<SigInUsecase>(SigInUsecase());
}
