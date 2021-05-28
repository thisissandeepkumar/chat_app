import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnackBarService {
  BuildContext? _buildContext;

  static SnackBarService instance = SnackBarService();

  SnackBarService() {}

  set buildContext(BuildContext context) {
    _buildContext = context;
  }

  void showSnackBarError(String message) {
    // ignore: deprecated_member_use
    Scaffold.of(_buildContext!).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            backgroundColor: Colors.red,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  void showSnackBarSuccess(String message) {
    // ignore: deprecated_member_use
    Scaffold.of(_buildContext!).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            backgroundColor: Colors.green,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
