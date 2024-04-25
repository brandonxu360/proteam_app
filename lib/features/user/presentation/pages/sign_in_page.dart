import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            const FaIcon(FontAwesomeIcons.drumstickBite, size: 90),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Login', style: Styles.title1),
                  const SizedBox(height: 25),
                  TextFormField(
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
                            fontWeight: FontWeight.bold,
                            fontSize: 24))),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
