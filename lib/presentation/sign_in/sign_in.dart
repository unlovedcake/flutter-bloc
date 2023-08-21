import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbloccrud/bloc/auth_bloc.dart';
import 'package:flutterbloccrud/constant/asset_storage_image.dart';
import 'package:flutterbloccrud/constant/firebase_instances.dart';
import 'package:flutterbloccrud/presentation/sign_up/sign_up.dart';
import 'package:flutterbloccrud/repository/auth_repository.dart';
import 'package:flutterbloccrud/router/router_page_animation.dart';

import '../dashboard/dashboard.dart';

part 'sign_in_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // User? firebaseUser;

  // @override
  // void initState() {
  //   firebaseAuth.authStateChanges().listen((user) {
  //     if (user == null) {
  //       return;
  //     }
  //     if (user.uid.isNotEmpty) {
  //       RouterPageAnimation.routePageAnimation(
  //           context, RouterPageAnimation.goToDashBoard());
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorSignIn) {
            // Showing the error message if the user has entered invalid credentials
            print('invalid email');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const DashBoard()));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // Showing the sign in form if the user is not authenticated
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                // validator: (value) {
                                //   return value != null &&
                                //           !EmailValidator.validate(value)
                                //       ? 'Enter a valid email'
                                //       : null;
                                // },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: Colors.white,
                                    shape: const StadiumBorder()),
                                onPressed: state is Loading
                                    ? null
                                    : () {
                                        _authenticateWithEmailAndPassword(
                                            context);
                                      },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    state is Loading
                                        ? const SpinKitFadingCircle(
                                            color: Colors.blue,
                                            size: 40.0,
                                          )
                                        : const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.blue,
                                            size: 20,
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const Text(
                            '  OR  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                //minimumSize: const Size(100, 50),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder()),
                            onPressed: () async {},
                            child: Image.asset(AssetStorageImage.facebook),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                //minimumSize: const Size(100, 50),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder()),
                            onPressed: () async {
                              _authenticateWithGoogle(context);
                            },
                            child: Image.asset(AssetStorageImage.google),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              RouterPageAnimation.routePageAnimation(
                                  context, RouterPageAnimation.goToSignUp());
                            },
                            child: const Text("Sign Up"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
