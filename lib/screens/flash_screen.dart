import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => FlashScreenState();
}

class FlashScreenState extends State<FlashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: AppLayout.getScreenWidth(),
          height: AppLayout.getScreenHeight(),
          decoration: BoxDecoration(
            image: DecorationImage(image:
                AssetImage("assets/flashscreen.jpg"),
            )
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Expanded(child: Container(),),
              Text("ĐĂNG TẢI MẪU CỦA BẠN",style: GoogleFonts.openSans(
                fontSize:40,fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
             GestureDetector(
               onTap: ()
               {
                 Get.to(()=>HomeScreen());
               },
               child: Container(
                 height: AppLayout.getHeight(50),
                 width: AppLayout.getWidth(150),
               decoration: BoxDecoration(
                 boxShadow: [
                   BoxShadow(
                     blurRadius: 5,
                     spreadRadius: 1.0,
                     color: Colors.grey
                   )
                 ],
                 borderRadius: BorderRadius.circular(5),
                 color: Colors.white
               ),
                 child: Align(
                   alignment: Alignment.center,
                   child: Text(
                     "Bắt đầu",
                     style: GoogleFonts.openSans(
                       color: Colors.blue[900],
                       fontSize:20,
                       fontWeight:FontWeight.bold
                     ),
                   ),
                 ),
               ),
             ),
              SizedBox(height: AppLayout.getHeight(50),)
            ]),
          ),
        ),
      ),
    );
  }
}
