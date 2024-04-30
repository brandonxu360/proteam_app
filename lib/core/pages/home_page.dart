import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/features/log/presentation/pages/dashboard_page.dart';
import 'package:proteam_app/features/log/presentation/pages/log_page.dart';
import 'package:proteam_app/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:proteam_app/features/user/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  // The uid of the user currently signed in
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controls which page to display
  late int screenIndex;

  // Top level pages (pages accessible from home)
  late List<Widget> homePages;

  @override
  void initState() {
    // Get the current user
    BlocProvider.of<UserCubit>(context).getSingleUser(uid: widget.uid);

    screenIndex = 0;

    homePages = [const DashboardPage(), const LogPage(), const ProfilePage()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Indexed stack used so that the state of the pages is maintained
      body: IndexedStack(
        index: screenIndex,
        children: homePages,
      ),

      // Use of container around GNav navigation bar to space navigation bar away from bottom of screen while maintaining continuity in color
      bottomNavigationBar: GNav(gap: 8, backgroundColor: blackColor, tabs: [
        GButton(
          iconActiveColor: boneColor,
          iconColor: greyColor,
          textColor: boneColor,
          icon: Icons.dashboard_rounded,
          text: 'Dashboard',
          onPressed: () {
            setState(() {
              screenIndex = 0;
            });
          },
        ),
        GButton(
          iconActiveColor: boneColor,
          iconColor: greyColor,
          textColor: boneColor,
          icon: Icons.book_rounded,
          text: 'Diary',
          onPressed: () {
            setState(() {
              screenIndex = 1;
            });
          },
        ),
        GButton(
            iconActiveColor: boneColor,
            iconColor: greyColor,
            textColor: boneColor,
            icon: Icons.person_rounded,
            text: 'Profile',
            onPressed: () => {
                  setState(() {
                    screenIndex = 2;
                  }),
                }),
      ]),
      floatingActionButton: (screenIndex == 0)
          ? FloatingActionButton.extended(
              backgroundColor: blackColor,
              label: const Text('Log Food', style: TextStyle(color: boneColor)),
              icon: const Icon(
                Icons.draw,
                color: boneColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteConst.searchFoodPage);
              })
          : null,
    );
  }
}
