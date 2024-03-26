import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/material.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => FlashScreenState();
}

class FlashScreenState extends State<FlashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppLayout.getScreenHeight(),
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(children: [Image.asset('assets/logo/logo_folder.jpg')]),
      ),
    );
  }
}
