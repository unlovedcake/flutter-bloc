import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firebaseAuth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;

final firebaseStorage = FirebaseStorage.instance;

DocumentSnapshot? lastDocSnapshotVisitors;
DocumentSnapshot? lastDocSnapshotRecommended;
