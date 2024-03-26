import 'dart:async';
// import 'package:appchat/screens/success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// export 'package:appchat/consts/firebase_consts.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    setTinerForAutoDirect();
    super.onInit();
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> sendEmailVerification() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
      Get.snackbar("Email đã được gửi đi", "Vui lòng kiểm tra Email của bạn");
    } catch (e) {
      Get.snackbar("Lỗi", "Đã xảy ra lỗi khi gửi email xác minh");
    }
  }

  setTinerForAutoDirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await firebaseAuth.currentUser?.reload();
      final user = firebaseAuth.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        //  Get.off(()=>SuccessScreen());
      }
    });
  }

  Future<void> checkEmailVerificationStatus() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      // Get.off(()=>SuccessScreen());
    }
  }
}
