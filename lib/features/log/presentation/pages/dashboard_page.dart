import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/utils/date_helpers.dart';
import 'package:proteam_app/core/widgets/image_widget.dart';
import 'package:proteam_app/features/user/presentation/cubit/user/user_cubit.dart';

// Dashboard/landing page
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadSuccess) {
          final user = state.user;

          return Column(
            children: [
              // Header
              ClipPath(
                clipper: BackgroundWaveClipper(),
                child: Container(
                  height: 180,
                  padding:
                      const EdgeInsets.only(left: 14, right: 14, bottom: 10),
                  decoration: const BoxDecoration(color: khakiColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.waving_hand_rounded,
                                  color: blackColor,
                                ),
                                const SizedBox(width: 12),
                                Text('Hello ${user.username}',
                                    style: const TextStyle(
                                      color: blackColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ))
                              ]),
                          const SizedBox(height: 2),
                          Text(formatDateLDF(DateTime.now()),
                              style: const TextStyle(
                                color: blackColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: imageWidget(
                                imageUrl: user.pfpUrl,
                                imageType: ImageType.profile)),
                      ),
                      const SizedBox(width: 10)
                    ],
                  ),
                ),
              )
            ],
          );
        } else if (state is UserLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}

// Clipper for the header container shape
class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  // Top bar container shape
  Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.5;
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, size.height * 0.75);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}
