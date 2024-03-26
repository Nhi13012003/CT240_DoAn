import 'package:ct240_doan/consts/firebase_const.dart';

class Validators {
  static Future<bool> isEmailExist(String email) async {
    try {
      var query = await firebaseFirestore
          .collection(collectionUser)
          .where('Email', isEqualTo: email)
          .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      print("Email da dc su dung");
      return false;
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập Email";
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Email không hợp lệ";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập Password";
    }
    if (value.length < 6) {
      return "Mật khẩu ít nhất 6 kí tự";
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập mật khẩu xác nhận";
    }
    if (value.length < 6) {
      return "Mật khẩu ít nhất 6 kí tự";
    }
    if (value != password) {
      return "mật khẩu xác nhận không trùng khớp";
    }
    return null;
  }
}
