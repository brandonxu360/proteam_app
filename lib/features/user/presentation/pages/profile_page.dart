import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/widgets/image_widget.dart';
import 'package:proteam_app/core/widgets/toast_widget.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:proteam_app/features/user/presentation/cubit/user/user_cubit.dart';

class ProfilePage extends StatefulWidget {
  // The uid of the user currently signed in
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // Get the current user
    BlocProvider.of<UserCubit>(context).getSingleUser(uid: widget.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
      child: Center(child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoadInProgress) {
            return const CircularProgressIndicator();
          } else if (state is UserLoadSuccess) {
            final user = state.user;
            return showUserInfo(context, user);
          } else {
            // Load failure
            return const Text(
                'An unexpected error occured when loading the profile, please try again later');
          }
        },
      )),
    );
  }

  Column showUserInfo(BuildContext context, UserEntity user) {
    return Column(
      children: [
        // Top bar
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 48),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: imageWidget(imageType: ImageType.profile)),
                ),
                const SizedBox(height: 20),
                Text(user.username, style: Styles.title1),
                const SizedBox(height: 10),
                Text(user.email, style: Styles.bodyText2)
              ],
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                // Reset app back to sign in page if unauthenticated state was emitted (sign out success)
                if (state is UnAuthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteConst.signInPage, (route) => false);
                }
                // There was an error signing out
                else if (state is SignOutError) {
                  toast(
                      'An unexpected sign out error occured, please try again later');
                }
              },
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).signOut();
                  },
                  icon: const Icon(Icons.logout)),
            )
          ],
        ),
      ],
    );
  }
}
