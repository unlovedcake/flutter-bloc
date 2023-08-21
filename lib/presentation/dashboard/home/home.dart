import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloccrud/bloc/product_bloc/product_bloc.dart';
import 'package:flutterbloccrud/constant/firebase_instances.dart';
import 'package:flutterbloccrud/model/user_model.dart';
import 'package:flutterbloccrud/router/router_page_animation.dart';

part 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> favoriteDocumentIds = [];
  Future<void> fetchFavoriteDocumentIds() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('favourites')
          .where('is_heart', isEqualTo: true)
          .get();

      setState(() {
        favoriteDocumentIds = querySnapshot.docs.map((doc) => doc.id).toList();
      });

      print(favoriteDocumentIds);
      print('favoriteDocumentIds');
    } catch (e) {
      print("Error fetching favorite document IDs: $e");
    }
  }

  Future<void> updateIsHeartField(String documentId) async {
    try {
      final options = SetOptions(merge: true);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('favourites')
          .doc(documentId)
          .set({
        'is_heart': false,
      }, options);
    } catch (e) {
      print("Error updating is_heart field: $e");
    }
  }

  Future<void> getAllFavourites() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('favourites')
          .where('is_heart', isEqualTo: true)
          .get();

      final userDocs = querySnapshot.docs.map(
        (doc) {
          return (doc['product_reference']);
        },
      ).toList();

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        (await userDocs[i]);
        print((await userDocs[i]));
        print('zz');
        print(userDocs.length.toString());
      }

      // for (int i = 0; i < result.docs.length; i++) {
      //   comments.add(UserModel.fromMap({
      //     'id': result.docs[i].id,
      //     'postId': result.docs[i]['postId'] as String,
      //     'user': (await userDocs[i]).data(),
      //     'comment': result.docs[i]['description'] as String,
      //   }));
      //   // comments.add(CommentModel.fromMap({
      //   //   'commentId': result.docs[i].id,
      //   //   'postId': result.docs[i]['postId'] as String,
      //   //   'userDoc': (await userDocs[i]).data(),
      //   //   'description': result.docs[i]['description'] as String,
      //   // }));
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getAllProducts();
    fetchFavoriteDocumentIds();
    getAllFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the value as needed
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(36.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the value as needed
                        ),
                        child: Image.asset(
                          'asset/images/google.png', // Replace with your image asset path
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 10,
                        children: [
                          const Text(
                            'Widget Title',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '200.00',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                RouterPageAnimation.routePageAnimation(context,
                                    RouterPageAnimation.goToAddProduct());
                              },
                              child: const Text('Buy Now'))
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: Text('View All'))
                      ],
                    ),
                    const DefaultTabController(
                        length: 5,
                        child: TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(
                              child: Text(
                                'Shoe',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text('Gadgets',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Tab(
                              child: Text('Tshirt',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Tab(
                              child: Text('Electronics',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Tab(
                              child: Text('Phone',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular Products',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    TextButton(onPressed: () {}, child: Text('View All'))
                  ],
                ),
                Column(
                  children: [
                    BlocConsumer<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductsLoading) {
                          return Text('Loading');
                        } else if (state is ProductsLoaded) {
                          final products = state.products;

                          return SizedBox(
                            height: 400,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // mainAxisSpacing: 10.0,
                                // crossAxisSpacing: 10.0,
                              ),
                              itemCount: products!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final product = products[index];
                                return Card(
                                  elevation: 4.0,
                                  child: Stack(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Image.network(
                                              product.imageUrl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: 140,
                                            ),
                                            Text(product.name),
                                            Text(product.price)
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: 8.0,
                                          left: 2.0,
                                          child: Text('Discount 10%')),
                                      Positioned(
                                        top: 4.0,
                                        right: 0.0,
                                        child: IconButton(
                                          icon: favoriteDocumentIds
                                                  .contains(product.id)
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.red,
                                                )
                                              : Icon(Icons.favorite_border),
                                          onPressed: () {
                                            if (favoriteDocumentIds
                                                .contains(product.id)) {
                                              updateIsHeartField(product.id);
                                              setState(() {
                                                _getAllProducts();
                                                fetchFavoriteDocumentIds();
                                              });
                                            } else {
                                              final userRef = fireStore
                                                  .collection('users')
                                                  .doc(firebaseAuth
                                                      .currentUser!.uid)
                                                  .collection('favourites')
                                                  .doc(product.id);

                                              userRef.set({
                                                'is_heart': true,
                                                'product_id': product
                                                    .id // This associates the user ID with the favourite
                                              }..addEntries({
                                                  'product_reference':
                                                      'products/${product.id}'
                                                }.entries));

                                              setState(() {
                                                _getAllProducts();
                                                fetchFavoriteDocumentIds();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                          // Expanded(
                          //   child: ListView.builder(
                          //     itemCount: products!.length,
                          //     itemBuilder: (context, index) {
                          //       final product = products[index];
                          //       return ListTile(
                          //         title: Text(product.name),
                          //         subtitle: Text('\$${product.price}'),
                          //       );
                          //     },
                          //   ),
                          // );
                        } else {
                          return SizedBox();
                        }
                      },
                      listener: (context, state) {
                        if (state is ProductsError) {
                          // Displaying the error message if the user is not authenticated
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                Image.network(
                  'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9989cd60-470b-4c37-b61c-d94a019819ce/freak-4-basketball-shoes-zmXv3D.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 140,
                ),
                Text('Black Long Show'),
                Text('200.00')
              ],
            ),
          ),
          Positioned(top: 8.0, left: 2.0, child: Text('Discount 10%')),
          Positioned(
            top: 4.0,
            right: 0.0,
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                // Assuming you have the necessary variables defined: userId, productId
                final userRef = fireStore
                    .collection('users')
                    .doc(firebaseAuth.currentUser!.uid);
                final favouritesRef = userRef
                    .collection('favourites')
                    .doc('aMwWakCuZnKTv4kY9Wzz');

                favouritesRef.set({
                  'is_heart': true,
                  'product_id':
                      'aMwWakCuZnKTv4kY9Wzz' // This associates the user ID with the favourite
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
