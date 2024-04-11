import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:ct240_doan/details/userData.dart';
import 'package:ct240_doan/screens/duan_screen.dart';
import 'package:ct240_doan/screens/personal_project_list.dart';
import 'package:ct240_doan/utils/pickAvatar.dart';
import 'package:ct240_doan/widgets/edit_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ct240_doan/modal/modal_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DrawerComponent extends StatefulWidget {
  final UserDataDetail? userDataDetail;
  final User? currentUser;

  const DrawerComponent(
      {super.key, required this.userDataDetail, required this.currentUser});

  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  Uint8List? _image;
  var _avatarUrl;

  void selectAvatar() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    uploadCurrentAvatar(img);
    setState(() {
      _image = img;
    });

    widget.userDataDetail!.avatar = _avatarUrl;
  }

  Future<void> handleChangeName(String name) async {
    setState(() {
      widget.userDataDetail!.username = name;
    });
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(currentUser?.uid).update({'username': name});
    print("Name has changed become $name");
  }

  Future<void> uploadCurrentAvatar(Uint8List image) async {
    if (currentUser != null) {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('avatars')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putData(image);
      _avatarUrl = await ref.getDownloadURL();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(currentUser?.uid).update({'avatar': _avatarUrl});
    } else {
      print('No user signed in');
    }
    setState(() {
      widget.userDataDetail!.avatar = _avatarUrl;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                'Thông tin tài khoản',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Edititem(
                tilte: 'Photo',
                widget: Column(
                  children: [
                    widget.userDataDetail!.avatar != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.userDataDetail!.avatar,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(), // Hiển thị indicator khi hình ảnh đang được tải
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Image.asset(
                              'assets/avatar_test.jpg',
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                    TextButton(
                      onPressed: selectAvatar,
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent),
                      child: const Text(
                        'Upload Image',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Edititem(
                widget: Container(
                  alignment: Alignment.center,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 221, 214, 214),
                          width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.userDataDetail!.username,
                            style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 26, 87, 109)),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Modal_card(
                                      changeName: handleChangeName);
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 15,
                          ),
                          splashColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                tilte: 'Họ và tên',
              ),
              Edititem(
                  widget: Container(
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 214, 214),
                            width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.userDataDetail!.email,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 26, 87, 109)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  tilte: 'Email'),
              Edititem(
                  widget: SizedBox(
                    height: 30,
                    child: Stack(children: [
                      Positioned(
                        right: 100,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const PersonalProjectList(),
                                arguments: currentUser!.uid,
                                transition: Transition.leftToRight);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Text(
                            '${widget.userDataDetail!.projectCounter.toString()} dự án',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.blue),
                          ),
                        ),
                      )
                    ]),
                  ),
                  tilte: 'Số lượng dự án'),
            ],
          ),
        ),
      ),
    );
  }
}
