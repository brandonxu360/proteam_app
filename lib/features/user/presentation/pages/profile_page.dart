import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/storage/storage_provider.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/widgets/circularProgress_widget.dart';
import 'package:proteam_app/core/widgets/image_widget.dart';
import 'package:proteam_app/core/widgets/snackbar_widget.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:proteam_app/features/user/presentation/cubit/user/user_cubit.dart';

class ProfilePage extends StatefulWidget {


  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
            return showProfile(context, user);
          } else {
            // Load failure
            return const Text(
                'An unexpected error occured when loading the profile, please try again later');
          }
        },
      )),
    );
  }

  Column showProfile(BuildContext context, UserEntity user) {
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
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: imageWidget(
                            imageUrl: user.pfpUrl,
                            imageType: ImageType.profile)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        pickImage(context).then((image) async {
                          // If an image was selected
                          if (image != null) {
                            // Show a circular progress indicator while uploading the image
                            circularProgress(context);

                            // Upload the image and update the user doc
                            await updatePfp(user, image, context)
                                .then((value) => Navigator.pop(context));
                          }
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: khakiColor,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: blackColor,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ]),
                const SizedBox(height: 20),
                Text(user.username, style: Styles.title2),
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
                  snackBar(context,
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

  Future<File?> pickImage(context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      snackBar(context, 'Failed to pick image: $e');
      return null;
    }
  }

  Future<void> updatePfp(UserEntity userEntity, File imageFile, context) async {
    try {
      // Upload the image
      await StorageProviderRemoteDataSource.updateProfileImage(
              file: imageFile, uid: userEntity.uid)
          .then((pfpUrl) {
        // Update the user doc
        BlocProvider.of<UserCubit>(context).updateUser(
            user: UserEntity(
                uid: userEntity.uid,
                email: userEntity.email,
                username: userEntity.username,
                pfpUrl: pfpUrl));
      });
    } catch (e) {
      snackBar(context, "Some error occured when updating profile image: $e");
    }
  }
}
