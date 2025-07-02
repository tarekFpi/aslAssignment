
import 'package:assignment_asl/core/features/auth/login_screen.dart';
import 'package:assignment_asl/core/features/home/home_screen.dart';
import 'package:assignment_asl/core/features/network/dio_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AuthController extends GetxController{

  final dioClient = DioClient.instance;

  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<TextEditingController> passwordController = TextEditingController().obs;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Rx‑ current user
  final Rxn<User> firebaseUser = Rxn<User>();

  final storage = GetStorage();


void checkAuth(){

  // ❶ listen to auth stream
  firebaseUser.bindStream(_auth.authStateChanges());

  // ❷ whenever firebaseUser changes, run _setInitialScreen
  ever<User?>(firebaseUser, _setInitialScreen);

}

  // first frame is rendered → safe to navigate
  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  ///  Email Password SignUp

  RxBool singUpLoading = false.obs;
  Future<void> signUp(String email, String password) async {

     try {
      singUpLoading(true);

      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      Get.snackbar('Success', 'Account created',snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);

      Get.offAll(LoginScreen());

      singUpLoading(false);
    } on FirebaseAuthException catch (e) {
      singUpLoading(false);
      Get.snackbar('Sign‑Up Error', e.message ?? 'Unknown error',
          snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red,colorText: Colors.white);
    }
  }


  /// 🔑 Email Password SignIn

  RxBool sinInLoading = false.obs;
  Future<void> signIn(String email, String password) async {
    try {
      sinInLoading(true);

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      sinInLoading(false);

      Get.snackbar('Login','SuccessFull',
          snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green,colorText: Colors.white);

      Get.offAll(HomeScreen());

    } on FirebaseAuthException catch (e) {
      sinInLoading(false);
      Get.snackbar('Login Error', e.message ?? 'Unknown error',
          snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red,colorText: Colors.white);
    }
  }


  /// 🚪 SignOut
  Future<void> signOut() async => await _auth.signOut();

}