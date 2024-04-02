import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SampleComponent(MauDetail mauDetail) {
  return SizedBox(
    width: AppLayout.getHeight(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.newspaper,
          color: Colors.blue,
        ),
        SizedBox(
          width: AppLayout.getWidth(20),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(
                  mauDetail.tenMau,
                ),
                Text(mauDetail.ngayLayMau),
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
      ],
    ),
  );
}
