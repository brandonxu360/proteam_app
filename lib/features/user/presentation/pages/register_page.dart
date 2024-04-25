import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/utils/form_validation_helpers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              // Spacer
              const SizedBox(height: 10),

              // Header (logo and title)
              const Column(
                children: [
                  FaIcon(FontAwesomeIcons.drumstickBite, size: 90, color: boneColor),
                  SizedBox(height: 20),
                  Text(
                    'Proteam',
                    style: Styles.title1,
                  )
                ],
              ),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, nice to meet you!',
                                style: Styles.headline1),
                            SizedBox(height: 2),
                            Text('Please enter your details',
                                style: Styles.bodyText2),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom: 150),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          labelText: 'Email',
                          helperText: ''),
                      validator: (value) {
                        if (!notEmptyCheck(value)) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom: 220),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          labelText: 'Password',
                          helperText: ''),
                      validator: (value) {
                        if (!notEmptyCheck(value)) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              // Options
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: boneColor,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(15),
                      child: const Center(
                          child: Text('Register',
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
                      const Text('Already have an account?'),
                      GestureDetector(
                          onTap: () {
                            // Pop back to the sign in page
                            Navigator.pop(context);
                          },
                          child: const Text(
                            ' Sign in',
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
    )));
  }
}
