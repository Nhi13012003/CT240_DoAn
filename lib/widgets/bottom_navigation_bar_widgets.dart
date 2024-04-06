import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavigationbarWidget extends StatelessWidget {
  var onArrowBackPressed;

  var onArrowForwardPressed;

  BottomNavigationbarWidget(
      {super.key,
      required this.onArrowBackPressed,
      required this.onArrowForwardPressed});
  static final icons = <Icon>[
    const Icon(Ionicons.arrow_back_outline),
    const Icon(Ionicons.arrow_forward_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onArrowBackPressed,
              icon: const Icon(
                Ionicons.arrow_back_outline,
                size: 30,
              ),
            ),
            IconButton(
                onPressed: onArrowForwardPressed,
                icon: const Icon(
                  Ionicons.arrow_forward_outline,
                  size: 30,
                )),
          ],
        ),
      ),
    );
  }
}
