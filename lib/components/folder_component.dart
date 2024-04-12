import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget FolderComponent(String tenDuAn, String ngayTao, String type, String id) {
  return SizedBox(
    width: AppLayout.getHeight(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          type == "Folder" ? Icons.folder : Icons.newspaper,
          color: Colors.blue,
        ),
        SizedBox(
          width: AppLayout.getWidth(20),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenDuAn,
                ),
                Text(ngayTao),
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
      ],
    ),
  );
}
