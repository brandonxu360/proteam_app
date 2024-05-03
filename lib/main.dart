import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/pages/home_page.dart';
import 'package:proteam_app/core/routes/on_generate_routes.dart';
import 'package:proteam_app/core/services/main_injection_container.dart' as di;
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/features/food/presentation/cubit/food_cubit/food_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:proteam_app/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:proteam_app/features/user/presentation/pages/sign_in_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize service locator
  await di.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()..appStart()),
        BlocProvider(create: (context) => di.sl<FoodCubit>()),
        BlocProvider(create: (context) => di.sl<UserCubit>())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark, seedColor: boneColor),
            scaffoldBackgroundColor: raisinBlackColor,
            dialogBackgroundColor: slateGreyColor,
            appBarTheme: const AppBarTheme(color: slateGreyColor),
          ),
          initialRoute: '/',
          onGenerateRoute: OnGenerateRoute.route,
          routes: {
            '/': (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return HomePage(uid: authState.uid);
                  }
                  return const SignInPage();
                },
              );
            }
          }),
    );
  }
}
