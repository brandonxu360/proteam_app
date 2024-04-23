// Show a toast with the input message
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proteam_app/core/theme/color_style.dart';

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: isabellineColor,
      textColor: blackColor,
      fontSize: 16.0);
}