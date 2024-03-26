import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ct240_doan/consts/firebase_const.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  RxBool hiddenOfPassword = true.obs;
  RxBool hiddenOfConfirmPassword = true.obs;
  final ngaySinh = TextEditingController();
  final hoTen = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  Future<void> registerAccount(String hoten, String email, String password,
      String gioiTinh, String ngaySinh) async {
    if (await isEmailExists(email)) {
      Get.snackbar("Lỗi", "Email đã được sử dụng");
    } else {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //  UserDetails userDetails=UserDetails(hoTen: hoten, gioiTinh: gioiTinh, ngaySinh: ngaySinh, email: email, isOnline: false, lastActive: "",
      //  img_url: "", id: currentUser!.uid, pushToken: '');
      //  await createUser(userDetails);
    }
  }

  Future<bool> isEmailExists(String email) async {
    try {
      var check = await auth.fetchSignInMethodsForEmail(email);
      return check.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
// Future<void>createUser(UserDetails user) async
// {

//   await firebaseFirestore.collection(collectionUser).doc(currentUser!.uid).set(user.toJson())
//   .
//   catchError((error, stackTrace){
//     Get.snackbar("$error","Đã có lỗi xảy ra",
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.green.withOpacity(0.1),
//         colorText: Colors.red);
//   });
//   print("User Id: ${currentUser?.uid}");
// }
}
