import 'package:chat_app/services/snackbar_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}

class AuthProvider extends ChangeNotifier {
  AuthStatus? authStatus;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static AuthProvider instance = AuthProvider();

  void loginUserWithEmailandPassword(String email, String password) async {
    authStatus = AuthStatus.Authenticating;
    notifyListeners();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      authStatus = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("Logged In Successfully!");
    } catch (e) {
      SnackBarService.instance.showSnackBarError("Error :- $e");
      print(e);
      authStatus = AuthStatus.Error;
    }
    notifyListeners();
  }
}
