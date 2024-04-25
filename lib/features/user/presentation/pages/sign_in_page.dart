import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/utils/form_validation_helpers.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  const Column(
                    children: [
                      FaIcon(FontAwesomeIcons.drumstickBite, size: 90),
                      SizedBox(height: 20),
                      Text(
                        'Proteam',
                        style: Styles.title1,
                      )
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 5),
                            Text('Let\'s sign you in.',
                                style: Styles.headline1),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 150),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              labelText: 'Username',
                              helperText: ''),
                          validator: (value) {
                            if (!notEmptyCheck(value)) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 220),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              labelText: 'Password',
                              helperText: ''),
                          validator: (value) {
                            if (!notEmptyCheck(value)) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),

                        // Forgot password
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Forgot Password?'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: isabellineColor,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(15),
                          child: const Center(
                              child: Text('Log in',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22))),
                        ),
                      ),

                      const SizedBox(height: 25),
                      // Register option
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          GestureDetector(
                              onTap: () {
                                // Navigate to the register page
                                Navigator.pushNamed(context, RouteConst.registerPage);
                              },
                              child: const Text(
                                ' Register',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
