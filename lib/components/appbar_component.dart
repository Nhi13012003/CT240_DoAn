import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ct240_doan/utils/app_layout.dart';

Widget AppBarComponent(GlobalKey<ScaffoldState> key) {
  return Container(
    decoration: BoxDecoration(
    ),
    height: AppLayout.getHeight(40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: TextField(
              onTap: () {},
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: "Tìm kiếm dự án hoặc mẫu",
                  hintStyle: GoogleFonts.nunito(fontSize: 15)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
            width: 80,
            height: 50,
            child: Icon(
              Icons.settings,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
