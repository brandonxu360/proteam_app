import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/features/log/presentation/pages/dashboard_page.dart';
import 'package:proteam_app/features/log/presentation/pages/log_page.dart';
import 'package:proteam_app/features/user/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controls which page to display
  int screenIndex = 0;

  // Top level pages (pages accessible from home)
  final homePages = [
    const DashboardPage(),
    const LogPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Indexed stack used so that the state of the pages is maintained
      body: IndexedStack(
        index: screenIndex,
        children: homePages,
      ),

      // Use of container around GNav navigation bar to space navigation bar away from bottom of screen while maintaining continuity in color
      bottomNavigationBar: GNav(
          gap: 8,
          backgroundColor: slateGreyColor,
          tabs: [
            GButton(
              icon: Icons.dashboard_rounded,
              text: 'Dashboard',
              onPressed: () {
                setState(() {
                  screenIndex = 0;
                });
              },
            ),
            GButton(
              icon: Icons.book_rounded,
              text: 'Diary',
              onPressed: () {
                setState(() {
                  screenIndex = 1;
                });
              },
            ),
            GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
                onPressed: () => {
                      setState(() {
                        screenIndex = 2;
                      }),
                    }),
          ]),
    );
  }
}
