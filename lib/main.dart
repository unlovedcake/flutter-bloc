// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutterbloccrud/bloc/auth_bloc.dart';
// import 'package:flutterbloccrud/firebase_options.dart';
// import 'package:flutterbloccrud/repository/auth_repository.dart';
// import 'package:flutterbloccrud/repository/product_repository.dart';

// import 'bloc/product_bloc/product_bloc.dart';
// import 'presentation/dashboard/dashboard.dart';
// import 'presentation/sign_in/sign_in.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(MultiBlocProvider(
//     providers: [
//       BlocProvider<AuthBloc>(
//         create: (context) => AuthBloc(),
//       ),
//       BlocProvider<ProductBloc>(
//         create: (BuildContext context) => ProductBloc(),
//       ),
//     ],
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasData) {
//               return const DashBoard();
//             }
//             // Otherwise, they're not signed in. Show the sign in page.
//             return const SignIn();
//           }),
//     );
//   }
// }
