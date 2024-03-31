import 'package:flutter/material.dart';

class Edititem extends StatelessWidget {
  final Widget widget;
  final String tilte;
  const Edititem({
    super.key,
    required this.widget,
    required this.tilte,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tilte,
                style: const TextStyle(fontSize: 22, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: widget,
          ),
        ],
      ),
    );
  }
}
