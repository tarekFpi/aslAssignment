import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class Toast {
  static errorToast(String message) {
    showToast(message, dismissOtherToast: true, position: ToastPosition.bottom, backgroundColor: Colors.red, radius: 8);
  }
  static successToast(String message) {
    showToast(message, dismissOtherToast: true, position: ToastPosition.bottom, backgroundColor: Colors.green,duration: const Duration(seconds: 4), radius: 8);
  }
}