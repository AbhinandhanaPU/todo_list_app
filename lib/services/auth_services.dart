import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_app/constants/firebase_errors.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Function to track if the user is logged in or logged out
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Function to to login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      log('Login failed: $e');
      return null;
    }
  }

  // Function to signup for the new users
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      log('FirebaseAuthException: ${error.message}');
      handleFirebaseError(error);
      return null;
    } catch (e) {
      log('Signup failed: $e');
      return null;
    }
  }

  // Function to logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
