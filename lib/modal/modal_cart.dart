import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class Modal_card extends StatelessWidget {
  Modal_card({
    required this.changeName,
    super.key,
  });

  String newName = '';
  final Function changeName;
  void handleOnclick() {
    changeName(newName);
  }

  void showSuccessDialog(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Transaction Completed Successfully!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Color.fromARGB(255, 208, 240, 245),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 180,
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  newName = text;
                },
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                    labelText: 'Tên mới',
                    labelStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    onPressed: () {
                      if (newName != '') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Xác nhận'),
                                content:
                                    Text('Bạn có muốn đổi tên thành $newName'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Get.back(); // Đóng AlertDialog khi nhấn 'No'
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      handleOnclick();
                                      Navigator.of(context).pop();
                                      Get.back();
                                      showSuccessDialog(context);
                                      // Đóng AlertDialog khi nhấn 'Yes'
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(250, 40)),
                    ),
                    child: const Text(
                      'Lưu',
                      style: TextStyle(fontSize: 25),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
