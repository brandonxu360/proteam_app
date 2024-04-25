import 'package:flutter/material.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/features/food/presentation/pages/create_food_page.dart';
import 'package:proteam_app/features/user/presentation/pages/register_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;

    switch (name) {
      case RouteConst.createFoodPage:
        {
          return materialPageBuilder(const CreateFoodPage());
        }

      case RouteConst.registerPage:
        {
          return materialPageBuilder(const RegisterPage());
        }
    }

    return null;
  }
}

// Helper material page route builder
dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

// Debugging purposes
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child:
            Text("Error: check that you provided the nessessary route args!"),
      ),
    );
  }
}
