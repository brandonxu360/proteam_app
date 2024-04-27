import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/utils/form_validation_helpers.dart';
import 'package:proteam_app/core/widgets/toast_widget.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Text field controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  FaIcon(FontAwesomeIcons.drumstickBite,
                      size: 90, color: boneColor),
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
                      controller: _usernameController,
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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                  // Register button
                  BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                    // Display a toast if authentication was not successful
                    if (state is AuthProcessFailure) {
                      toast('Something went wrong');
                    }

                    // Navigate to the home page if the authentication was successful
                    if (state is Authenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteConst.homePage, (route) => false,
                          arguments: state.uid);
                    }
                  }, builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Attempt to register the user
                          BlocProvider.of<AuthCubit>(context)
                              .registerWithEmailPassword(_emailController.text,
                                  _passwordController.text);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: boneColor,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: (state is AuthProcessInProgress)
                                ? const CircularProgressIndicator()
                                : const Text('Register',
                                    style: TextStyle(
                                        color: blackColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22))),
                      ),
                    );
                  }),

                  const SizedBox(height: 25),
                  // Sign in option
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
