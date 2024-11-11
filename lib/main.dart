import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_theme.dart';
import 'package:spotify_clone_with_flutter/firebase_options.dart';
import 'package:spotify_clone_with_flutter/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/splash/splash_page.dart';
import 'package:spotify_clone_with_flutter/service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ChangeTheme())],
      child: BlocBuilder<ChangeTheme, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          themeMode: mode,
          darkTheme: AppTheme.darkTheme,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
