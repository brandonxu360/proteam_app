import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  // The uid of the user currently signed in
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
      child: Center(
          child: Column(
        children: [
          Material(
            shape: const CircleBorder(),
            color: Theme.of(context).colorScheme.primaryContainer,
            // Splash effect
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                BlocProvider.of<AuthCubit>(context).signOutUseCase();

                Navigator.pushNamedAndRemoveUntil(
                    context, RouteConst.signInPage, (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.logout,
                ),
              ),
            ),
          ),
          Text('Welcome $uid')
        ],
      )),
    );
  }
}
