import 'package:chat_alpha_sept/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'cubits/index.dart';
import 'services/index.dart';
import 'utils/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  Bloc.observer = ConvoBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ConvoApp(
    authService: AuthService(),
  ));
}

class ConvoApp extends StatelessWidget {
  final AuthService authService;
  const ConvoApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MainCubit()),
          BlocProvider(create: (_) => AuthCubit(authService)),
          BlocProvider(create: (_) => ChatCubit()),
          BlocProvider(create: (_) => SettingsCubit()),
        ],
        child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {
            if (state.themeState == ThemeState.system) {
              Style().systemOverlay(context);
            }
            if (state.themeState == ThemeState.light) {
              Style().lightOverlay(context);
            }
            if (state.themeState == ThemeState.dark) {
              Style().darkOverlay(context);
            }
          },
          builder: (context, state) {
            return ScreenUtilInit(
              builder: (context, child) => MaterialApp(
                title: 'Convo',
                debugShowCheckedModeBanner: false,
                theme: context.watch<MainCubit>().light,
                darkTheme: context.watch<MainCubit>().dark,
                themeMode: context.watch<MainCubit>().themeMode,
                initialRoute: context.watch<AuthCubit>().isLogin ? 'chat' : '/',
                onGenerateRoute: Routes.onGenerateRoute,
              ),
            );
          },
        ));
  }
}
