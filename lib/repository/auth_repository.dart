import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbloccrud/constant/firebase_instances.dart';
import 'package:flutterbloccrud/logs/my_logger.dart';
import 'package:flutterbloccrud/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  static final _firebaseAuth = FirebaseAuth.instance;

  static Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateProfile(
        displayName: name,
        photoURL:
            'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj',
      );

      final user = UserModel(
          id: _firebaseAuth.currentUser!.uid, name: name, email: email);

      await fireStore.collection('users').doc(user.id).set(user.toMap());
      MyLogger.printInfo('Successfully Registered.');
    }
    // on FirebaseAuthException catch (e) {
    //   MyLogger.printError(e);
    //   if (e.code == 'weak-password') {
    //     throw Exception('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     throw Exception('The account already exists for that email.');
    //   } else if (e.code == 'invalid-email') {
    //     throw Exception('The email address is badly formatted.');
    //   }
    // }
    catch (e) {
      MyLogger.printError(e);
      throw Exception(e.toString());
    }
  }

  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      MyLogger.printInfo('You are now logged in.');
    }
    // on FirebaseAuthException catch (e) {
    //   MyLogger.printError(e);
    //   if (e.code == 'user-not-found') {
    //     throw Exception('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     throw Exception('Wrong password provided for that user.');
    //   }
    // }
    catch (e) {
      MyLogger.printError(e);
      throw Exception(e.toString());
    }
  }

  static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      MyLogger.printError('You are now signed with Google Account');
    } catch (e) {
      MyLogger.printError(e);
      throw Exception(e.toString());
    }
  }

  static Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> addUser(UserModel user) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.id).set(user.toMap());
  }
}
