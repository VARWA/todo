import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
  bool _authenticated = false;

  bool get authenticated => _authenticated;

  set authenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}
