import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/views/home_view.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        "Done",
        "สมัครสมาชิกสำเร็จ",
        backgroundColor: Colors.green.withOpacity(0.3),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.redAccent.withOpacity(0.3),
        colorText: Colors.white,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        "Done",
        "เข้าสู่ระบบสำเร็จ",
        backgroundColor: Colors.green.withOpacity(0.3),
        colorText: Colors.white,
      );
      Get.off(HomeView());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.redAccent.withOpacity(0.3),
        colorText: Colors.white,
      );
    }
  }
}
