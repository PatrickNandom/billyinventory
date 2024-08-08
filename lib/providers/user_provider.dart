import 'package:billyinventory/models/user_model.dart';
import 'package:billyinventory/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  User? get getUser => _user;

  UserProvider() {
    _authService.userChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }
}
