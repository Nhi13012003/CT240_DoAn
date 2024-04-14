import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataDetail {
  late String id;
  late String username;
  late String email;
  late String password;
  late String avatar;
  late String birthday;
  late int projectCounter;
  UserDataDetail(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.avatar,
      required this.birthday,
      required this.projectCounter});
  toJson() {
    return {
      "id": email.hashCode.toString(),
      "username": username,
      "email": email,
      "password": password,
      "avatar": avatar,
      "birthday": birthday,
      "projectCounter": projectCounter,
    };
  }

  UserDataDetail.fromJson(Map<dynamic, dynamic> json) {
    username = json["username"].toString();
    id = json["Id"].toString();
    email = json["email"].toString();
    password = json["birthday"].toString();
    avatar = json["avatar"].toString();
    birthday = json["birthday"].toString();
    projectCounter = json["projectCounter"];
  }

  factory UserDataDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserDataDetail(
      id: data["id"] ?? "",
      username: data["username"] ?? "",
      email: data["email"] ?? "",
      password: data["password"] ?? "",
      avatar: data["avatar"] ?? "",
      birthday: data["birthday"] ?? "",
      projectCounter: data["projectCounter"] ?? 0,
    );
  }
}
