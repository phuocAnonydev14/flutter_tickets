import 'package:flutter/material.dart';
import 'package:ticket_app/models/User.dart';

class AuthService with ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  void login(String username, String email) {
    _user = User(username: username, email: email);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}