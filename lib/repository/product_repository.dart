import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterbloccrud/constant/firebase_instances.dart';
import 'package:flutterbloccrud/model/product_model.dart';

class ProductRepository {
  static const String _products = 'products';

  static Future<List<Product>> getSomeProducts(String ownerId) async {
    final collectionRef = fireStore.collection(_products);
    final query = collectionRef
        .where(Product.ID, isEqualTo: ownerId)
        .orderBy(Product.NAME)
        .limit(5);
    final result = await query.get();
    final products = result.docs.map((doc) {
      final map = doc.data();
      return Product.fromMap(map);
    }).toList();
    return products;
  }

  static Future<List<Product>> getAllProducts() async {
    final collectionRef = fireStore.collection(_products);
    final query = collectionRef.orderBy(Product.NAME);
    final result = await query.get();
    final products = result.docs.map((doc) {
      final map = doc.data();
      return Product.fromMap(map);
    }).toList();

    return products;
  }

  static Future<List<String>> fetchFavoriteDocumentIds() async {
    List<String> favoriteDocumentIds = [];
    try {
      QuerySnapshot querySnapshot = await fireStore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('favourites')
          .where('is_heart', isEqualTo: true)
          .get();

      return favoriteDocumentIds =
          querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      rethrow;
    }
  }
}
