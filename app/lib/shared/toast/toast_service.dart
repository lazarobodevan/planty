import 'package:app/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService{

  static void showSuccess({required String message}){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, // ou Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM,    // TOP, CENTER, BOTTOM
      backgroundColor: ThemeColors.primary2,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  static void showError({required String message}){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, // ou Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM,    // TOP, CENTER, BOTTOM
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}