import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/data/firestore.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password, BuildContext context);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Nếu đăng nhập thành công, chuyển màn hình
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Hiển thị lỗi nếu đăng nhập thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng nhập thất bại: ${e.toString()}")),
      );
    }
  }

  @override
  Future<String> register(String email, String password, String passwordConfirm) async {
    if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      return "Please fill in all fields!";
    }

    if (password != passwordConfirm) {
      return "Passwords do not match!";
    }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim())
          .then((value) {
        Firestore_Datasource().CreateUser(email);
      });

      return "success"; // Thành công

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email is already in use!";
      } else if (e.code == 'weak-password') {
        return "Password is too weak!";
      } else if (e.code == 'invalid-email') {
        return "Invalid email format!";
      } else {
        return "Registration failed. Please try again!";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}