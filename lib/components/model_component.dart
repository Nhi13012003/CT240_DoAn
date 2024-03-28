import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ModelComponent() {
  return Container(
    width: AppLayout.getWidth(90),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.blue),
    child: Column(
      children: [
        Expanded(
          child: Image.asset(
            "assets/logo/logo_folder.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Text(
          "Mẫu lúa mới nhất",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );
}
