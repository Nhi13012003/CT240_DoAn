import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Forward_Button extends StatelessWidget {
  final Function() onTap;
  const Forward_Button({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(Ionicons.chevron_forward_outline),
      ),
    );
  }
}
