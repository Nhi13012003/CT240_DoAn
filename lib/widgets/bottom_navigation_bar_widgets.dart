import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavigationbarWidget extends StatelessWidget {
  var onArrowBackPressed;

  var onArrowForwardPressed;
  var currentIndex;
  int listLenght;

  BottomNavigationbarWidget(
      {super.key,
      required this.onArrowBackPressed,
      required this.onArrowForwardPressed,
      required this.currentIndex,
      required this.listLenght});
  static final icons = <Icon>[
    const Icon(Ionicons.arrow_back_outline),
    const Icon(Ionicons.arrow_forward_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BottomAppBar(
          height: 50,
          color: Color.fromARGB(
              0, 198, 30, 30), // Đặt màu trong suốt cho BottomAppBar
          elevation: 0, // Vô hiệu hóa đường viền
        ),
        Positioned(
          bottom: 0, // Đặt vị trí dưới cùng
          left: 0, // Đặt vị trí bên trái
          right: 0, // Đặt vị trí bên phải
          child: Container(
            height: 50,
            color: const Color.fromARGB(
                139, 189, 186, 186), // Đặt màu trong suốt cho Container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Positioned(
                    left: 0, // Đặt vị trí bên trái cho IconButton đầu tiên
                    child: IconButton(
                      onPressed: onArrowBackPressed,
                      icon: Icon(
                        Ionicons.arrow_back_outline,
                        size: 25,
                        color: currentIndex == 0
                            ? const Color.fromARGB(116, 158, 158, 158)
                            : const Color.fromARGB(255, 73, 73, 73),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Positioned(
                    right: 0, // Đặt vị trí bên phải cho IconButton thứ hai
                    child: IconButton(
                      onPressed: onArrowForwardPressed,
                      icon: Icon(
                        Ionicons.arrow_forward_outline,
                        size: 25,
                        color: currentIndex == listLenght - 1
                            ? const Color.fromARGB(116, 158, 158, 158)
                            : const Color.fromARGB(255, 73, 73, 73),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
