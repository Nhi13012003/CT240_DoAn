import 'package:cloud_firestore/cloud_firestore.dart';

import '../consts/firebase_const.dart';

class UserSingleton
{

  static late String email;
  static late String hoTen;
  static final UserSingleton userSingleton = UserSingleton.internal();
  UserSingleton.internal();
  factory UserSingleton(){
    return userSingleton;
  }


  Future<void> getuser(String email) async
  {
    QuerySnapshot<Map<dynamic,dynamic>> querySnapshot=await firebaseFirestore.collection("users").where("email",isEqualTo: email)
        .get();
    var data=querySnapshot.docs.first.data();
    email=data["email"];
    hoTen=data["HoTen"];

  }
}