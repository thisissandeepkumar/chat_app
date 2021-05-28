import 'dart:io';

import 'package:chat_app/services/cloud_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  static DBService instance = DBService();
  FirebaseFirestore? _db;
  FirebaseAuth? firebaseAuth;

  DBService() {
    _db = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
  }

  String _userCollection = "Users";

  Future<void> createUserInDB(String uid, String name, String email,
      String password, File? file) async {
    String? _imageURL = null;
    if (file != null) {
      _imageURL = await CloudStorageService.instance.uploadToStorage(file);
    }
    try {
      await _db!.collection(_userCollection).doc(uid).set({
        "email": email,
        "lastSeen": DateTime.now(),
        "name": name,
        "image": _imageURL,
      });
    } catch (e) {
      print(e);
    }
  }
}
