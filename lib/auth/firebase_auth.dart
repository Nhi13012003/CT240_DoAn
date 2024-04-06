import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> SignUp(String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lưu thông tin về tên người dùng vào Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'email': email,
        'username': username,
        'projectCounter': 0,
        'birthday': '',
        'avatar': '',
        // Các trường thông tin khác có thể được thêm vào đây
      });

      return credential.user;
    } catch (e) {
      print("Đã có lỗi xảy ra: $e");
    }
    return null;
  }

  Future<User?> SignIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Đã có lỗi xảy ra: $e");
    }
    return null;
  }
}
