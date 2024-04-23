import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/pages/home_page.dart';
import 'package:proteam_app/core/services/main_injection_container.dart' as di;
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/features/food/presentation/cubit/food_cubit.dart';
import 'package:proteam_app/features/food/presentation/pages/create_food_page.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return BlocProvider(
      create: (context) => di.sl<FoodCubit>(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          theme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark, seedColor: boneColor),
            scaffoldBackgroundColor: raisinBlackColor,
            dialogBackgroundColor: slateGreyColor,
            appBarTheme: const AppBarTheme(color: slateGreyColor),
          )),
    );
  }
}
