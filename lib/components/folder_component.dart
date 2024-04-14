import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';

Widget FolderComponent(BuildContext context, String tenDuAn, String ngayTao,
    String type, String id) {
  TextEditingController editTenDuAn = TextEditingController();
  return SizedBox(
    width: AppLayout.getHeight(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        type == "DuAn"
            ? Icon(
                Icons.analytics_rounded,
                color: Colors.blue,
              )
            : Icon(
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
        PopupMenuButton(
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Text("Chỉnh sửa"),
              value: "edit",
            ),
            PopupMenuItem(
              child: Text("Xóa vĩnh viễn"),
              value: "delete",
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case "edit":
                if (type == "DuAn") {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (context, setStateForDialog) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            scrollable: true,
                            title: const Center(
                              child: Text(
                                "Dự án mới",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            content: Column(
                              children: [
                                SizedBox(
                                  height: AppLayout.getHeight(45),
                                  child: TextField(
                                    controller: editTenDuAn,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            bottom: 10, left: 10),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.blue)),
                                        hintText: "Nhập tên dự án",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Colors.blue[900] ??
                                                    Colors.blue))),
                                  ),
                                ),
                                SizedBox(
                                  height: AppLayout.getHeight(10),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        fixedSize: Size(
                                            AppLayout.getScreenWidth() * 0.7,
                                            AppLayout.getHeight(30))),
                                    child: Text(
                                      "Lưu",
                                      style: GoogleFonts.openSans(
                                          color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      firebaseFirestore
                                          .collection(collectionDuAn)
                                          .doc(id)
                                          .update({
                                        "TenDuAn": editTenDuAn.text.toString(),
                                      });
                                      Get.back();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.blue[900] ??
                                                    Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor: Colors.white,
                                        fixedSize: Size(
                                            AppLayout.getScreenWidth() * 0.7,
                                            AppLayout.getHeight(30))),
                                    child: Text(
                                      "Hủy",
                                      style: GoogleFonts.openSans(
                                          color: Colors.blue[900]),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                      });
                }
              case "delete":
                if (type == "DuAn") {
                  firebaseFirestore.collection(collectionDuAn).doc(id).delete();
                  break;
                }
            }
          },
        )
      ],
    ),
  );
}
