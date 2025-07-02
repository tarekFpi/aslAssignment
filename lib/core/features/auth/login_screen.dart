

import 'package:assignment_asl/core/features/auth/auth_controller.dart';
import 'package:assignment_asl/core/features/auth/signUp_screen.dart';
import 'package:assignment_asl/core/features/home/home_screen.dart';
import 'package:assignment_asl/core/features/theme/color_scheme.dart';
import 'package:assignment_asl/core/features/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool obscureText = true;
  String? email;
  String? password;
  bool rememberPassword = false;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

   final authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
          backgroundColor:colorScheme.surfaceVariant,
          body: SingleChildScrollView(
            child: Obx(
                ( ) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Lottie.asset("assets/animation/login.json",width: 300, height: 200)),

                      Text(
                        "Login with Firebase",
                        style: textTheme.titleMedium?.copyWith(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),


                      const SizedBox(
                        height: 30,
                      ),

                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: TextFormField(
                                initialValue: email,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter Your Email';
                                  }
                                  return null;
                                }, onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: Colors.white38,
                                    filled: true,
                                    hintText: "Enter  Password",
                                    prefixIcon: Icon(FluentIcons.person_24_regular,color: Colors.black38)
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 16,
                            ),
                            Card(
                              child: TextFormField(
                                initialValue: password,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter Your Password';
                                  }
                                  return null;
                                }, onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                                decoration: InputDecoration(
                                  fillColor: Colors.white38,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(16),
                                  hintText: "Enter Password",
                                  prefixIcon: Icon(Icons.lock_outline_rounded,color: HexColor('#855EA9'),),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        obscureText ? Icons.visibility : Icons.visibility_off,
                                        color: HexColor('#855EA9'),
                                      ),
                                      onPressed: togglePasswordVisibility),
                                ),

                                keyboardType: TextInputType.text,
                                obscureText: obscureText,
                              ),
                            ),



                            const SizedBox(
                              height: 16,
                            ),

                            authController.sinInLoading.value?Center(child: CircularProgressIndicator()):
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  //foregroundColor: colorScheme.onPrimary,
                                  backgroundColor:HexColor('#855EA9'),

                                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                onPressed: () async {

                                  if (formKey.currentState!.validate()) {

                                    await authController.signIn(email.toString(),password.toString());

                                  }

                                },
                                child: Text('Login ',style: textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: lightColorScheme!.onPrimary)),
                              ),
                            ),
                            const SizedBox(height: 12),

                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Get.to(SignupScreen());
                                }, //
                                child: const Text('Already have an account? SigUp'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ));
      }
    }
