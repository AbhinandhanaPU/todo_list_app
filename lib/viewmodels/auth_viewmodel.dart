// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/services/auth_services.dart';
import 'package:todo_list_app/view/tasks/task_list_screen.dart';
import 'package:todo_list_app/view/widgets_custom/custom_toast.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthViewModel(this._authService);

  Future<void> login(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    _setLoading(true);
    _currentUser = await _authService.login(email, password);
    _setLoading(false);
    if (_currentUser != null) {
      clearFields();
      showToast(msg: 'Login successful');
      log('Login successful: ${_currentUser!.email}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TaskListScreen(),
        ),
      );
    } else {
      showToast(msg: 'Login failed, Try Again');
      log('Login failed');
    }
  }

  Future<void> signUp(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    _setLoading(true);
    _currentUser = await _authService.signUp(email, password);
    _setLoading(false);
    if (_currentUser != null) {
      clearFields();
      showToast(msg: 'Signup successful');
      log('Signup successful: ${_currentUser!.email}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TaskListScreen(),
        ),
      );
    } else {
      showToast(msg: 'Signup failed, Try Again');
      log('Signup failed');
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
