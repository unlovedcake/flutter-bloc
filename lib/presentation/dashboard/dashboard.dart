import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloccrud/bloc/auth_bloc.dart';
import 'package:flutterbloccrud/bloc/product_bloc/product_bloc.dart';
import 'package:flutterbloccrud/constant/firebase_instances.dart';
import 'package:flutterbloccrud/presentation/dashboard/chat/chat.dart';
import 'package:flutterbloccrud/presentation/dashboard/home/home.dart';
import 'package:flutterbloccrud/presentation/dashboard/profile/profile.dart';
import 'package:flutterbloccrud/presentation/dashboard/search/search.dart';

import '../sign_in/sign_in.dart';

part 'dashboard_controller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   // leading: CircleAvatar(
      //   //     radius: 20,
      //   //     backgroundColor: Colors.blueGrey,
      //   //     child: Image.network("${user.photoURL}")),
      //   // title: Column(
      //   //   children: [
      //   //     const Text('Welcome'),
      //   //     Text(user.displayName!),
      //   //   ],
      //   // ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           context.read<AuthBloc>().add(SignOutRequested());
      //         },
      //         icon: Icon(Icons.logout))
      //   ],
      // ),
      body: ValueListenableBuilder<int>(
        builder: (BuildContext context, int value, Widget? child) {
          // This builder will only get called when the _counter
          // is updated.

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: IndexedStack(
              key: ValueKey(value),
              index: value,
              children: [Home(), Chat(), Search(), Profile()],
            ),
          );
        },
        valueListenable: _index,
        // The child parameter is most helpful if the child is
        // expensive to build and does not depend on the value from
        // the notifier.
      ),
      // Column(
      //   children: [
      //     BlocListener<AuthBloc, AuthState>(
      //       listener: (context, state) {
      //         if (state is UnAuthenticated) {
      //           // Navigate to the sign in screen when the user Signs Out
      //           Navigator.of(context).pushAndRemoveUntil(
      //             MaterialPageRoute(builder: (context) => SignIn()),
      //             (route) => false,
      //           );
      //         }
      //       },
      //       child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      //         if (state is Authenticated) {
      //           final user = firebaseAuth.currentUser!;
      //           return Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   'Email: \n ${user.email}',
      //                   style: const TextStyle(fontSize: 24),
      //                   textAlign: TextAlign.center,
      //                 ),
      //                 user.photoURL != null
      //                     ? Image.network("${user.photoURL}")
      //                     : Container(),
      //                 user.displayName != null
      //                     ? Text("${user.displayName}")
      //                     : Container(),
      //                 const SizedBox(height: 16),
      //               ],
      //             ),
      //           );
      //         } else {
      //           return SizedBox();
      //         }
      //       }),
      //     ),
      //     SizedBox(height: 20),
      //     BlocConsumer<ProductBloc, ProductState>(
      //       builder: (context, state) {
      //         if (state is ProductsLoading) {
      //           return Text('Loading');
      //         } else if (state is ProductsLoaded) {
      //           final products = state.products;

      //           return Expanded(
      //             child: ListView.builder(
      //               itemCount: products!.length,
      //               itemBuilder: (context, index) {
      //                 final product = products[index];
      //                 return ListTile(
      //                   title: Text(product.name),
      //                   subtitle: Text('\$${product.price}'),
      //                 );
      //               },
      //             ),
      //           );
      //         } else {
      //           return SizedBox();
      //         }
      //       },
      //       listener: (context, state) {
      //         if (state is ProductsError) {
      //           // Displaying the error message if the user is not authenticated
      //           ScaffoldMessenger.of(context)
      //               .showSnackBar(SnackBar(content: Text(state.error)));
      //         }
      //       },
      //     ),
      //   ],
      // ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        color: Colors.blue,
        activeColor: Colors.black,
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.chat, title: 'Chat'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (currentIndex) {
          _index.value = currentIndex;
        },
      ),
    );
  }
}
