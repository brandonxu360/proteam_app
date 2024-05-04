import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proteam_app/core/const/route_const.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/utils/form_validation_helpers.dart';
import 'package:proteam_app/core/widgets/snackbar_widget.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // Text field controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

                  // Header
                  const Column(
                    children: [
                      FaIcon(FontAwesomeIcons.drumstickBite,
                          size: 90, color: boneColor),
                      SizedBox(height: 20),
                      Text(
                        'Proteam',
                        style: Styles.title2,
                      )
                    ],
                  ),

                  // Form (text form fields)
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
                          controller: _emailController,
                          scrollPadding: const EdgeInsets.only(bottom: 150),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              labelText: 'Email',
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
                          controller: _passwordController,
                          scrollPadding: const EdgeInsets.only(bottom: 220),
                          obscureText: true,
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

                  // Buttons and options
                  Column(
                    children: [
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          // Display a toast if sign in was not successful
                          if (state is SignInError) {
                            snackBar(context,
                                'An unexpected error occured, please try again later');
                          } else if (state is SignInFailure) {
                            snackBar(
                                context, 'Sign in failed: ${state.feedback}');
                          }

                          // Navigate to the home page if the authentication was successful
                          else if (state is SignInAuthenticated) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteConst.homePage, (route) => false,
                                arguments: state.uid);
                          }
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form fields pass the validation checks, attempt to sign user in
                                BlocProvider.of<AuthCubit>(context)
                                    .signInWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: boneColor,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                  // Return a circular progress indicator if the authentication is currently in progress, regular 'register' text otherwise
                                  child: (state is SignInInProgress)
                                      ? const CircularProgressIndicator(
                                          color: blackColor,
                                        )
                                      : const Text('Log in',
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22))),
                            ),
                          );
                        },
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
                                Navigator.pushNamed(
                                    context, RouteConst.registerPage);
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
