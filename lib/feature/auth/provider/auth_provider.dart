// lib/features/auth/providers/auth_provider.dart
import 'package:flutter/material.dart';

import '../../../core/utils/handler.dart';
import '../../../data/model/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  List<UserModel> _users = [];

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final usersData = await FileHandler.readUsers();
      _users = usersData
          .where((user) => user is Map)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } catch (e) {
      print('Error loading users: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await loadUsers();

      final user = _users.firstWhere(
        (user) => user.email == email,
        orElse: () => throw Exception('User not found'),
      );

      // Dalam implementasi nyata, password harus di-hash
      if (password == 'password') {
        // Ganti dengan verifikasi password yang benar
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Invalid password');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      await loadUsers();

      // Cek email sudah terdaftar
      if (_users.any((user) => user.email == email)) {
        throw Exception('Email already registered');
      }

      // Buat user baru
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
        avatar: 'https://via.placeholder.com/150',
        isOnline: true,
      );

      _users.add(newUser);

      await FileHandler.writeUsers(_users);

      _currentUser = newUser;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
