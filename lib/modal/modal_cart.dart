import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: Color.fromARGB(255, 208, 240, 245),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        height: 250,
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                newName = text;
              },
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                labelText: 'Tên mới',
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: handleOnclick,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(250, 40)),
                  ),
                  child: const Text(
                    'Lưu',
                    style: TextStyle(fontSize: 25),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
