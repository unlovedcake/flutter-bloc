import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/product_bloc/product_bloc.dart';
import 'enums/flavor_enum.dart';
import 'secrets/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
      // const MyApp(
      //   flavor: Flavor.development,
      // ),
      MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
      ),
      BlocProvider<ProductBloc>(
        create: (BuildContext context) => ProductBloc(),
      ),
    ],
    child: const MyApp(
      flavor: Flavor.development,
    ),
  ));
}
