import 'package:ct240_doan/modal/modal_cart.dart';
import 'package:ct240_doan/modal/users.dart';
import 'package:ct240_doan/screens/login_page.dart';
import 'package:ct240_doan/widgets/edit_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late UserData userData;
  // ignore: prefer_typing_uninitialized_variables
  bool _isObscured = false;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    userData = UserData(
      id: '1',
      name: "Đây là test name",
      email: 'Đây là Email Test',
      password: '1522003',
    );
    textController = TextEditingController(text: userData.name);
    _isObscured = true;
    print(_isObscured);
    print(textController);
  }

  void handleChangeName(String name) {
    setState(() {
      userData.name = name;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Ionicons.chevron_back_outline,
              color: Colors.lightBlueAccent,
              size: 32,
            )),
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text(
                          'Xác nhận',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40),
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            return const SizedBox(
                              height: 50,
                              width: 300,
                              child: Text(
                                'Lưu thay đổi',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'))
                        ],
                      )),
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                fixedSize: const Size(60, 50),
                elevation: 10,
              ),
              icon: const Icon(
                Ionicons.checkmark,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Thông tin tài khoản',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Edititem(
              tilte: 'Photo',
              widget: Column(
                children: [
                  Image.asset(
                    'assets/images.png',
                    width: 160,
                    height: 160,
                  ),
                  TextButton(
                    onPressed: () {},
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
            const SizedBox(
              height: 15,
            ),
            Edititem(
              widget: Container(
                alignment: Alignment.center,
                height: 60,
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
                          userData.name,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 26, 87, 109)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Modal_card(changeName: handleChangeName);
                            });
                      },
                      icon: const Icon(Ionicons.create_outline),
                    ),
                  ],
                ),
              ),
              tilte: 'Họ và tên',
            ),
            Edititem(
                widget: Container(
                  alignment: Alignment.center,
                  height: 60,
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
                            userData.email,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 26, 87, 109)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                tilte: 'Email'),
            Edititem(
                widget: Container(
                  alignment: Alignment.center,
                  height: 60,
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
                            child: TextField(
                              enabled: false,
                              obscureText: _isObscured, // Ẩn văn bản nhập vào
                              controller: TextEditingController(
                                  text: userData
                                      .password), // Đặt giá trị mật khẩu
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 26, 87, 109)),
                              decoration: const InputDecoration(
                                border: InputBorder.none, // Không có đường viền
                              ),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: _isObscured
                              ? const Icon(Ionicons.eye_outline)
                              : const Icon(Ionicons.eye_off_outline)),
                    ],
                  ),
                ),
                tilte: 'Mật khẩu'),
            const Edititem(
                widget: SizedBox(
                  height: 30,
                  child: Stack(children: [
                    Positioned(
                      right: 200,
                      child: Text(
                        '25 dự án',
                        style: TextStyle(fontSize: 22, color: Colors.grey),
                      ),
                    )
                  ]),
                ),
                tilte: 'Số lượng dự án'),
            Edititem(widget: Container(), tilte: 'Sinh nhật'),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
