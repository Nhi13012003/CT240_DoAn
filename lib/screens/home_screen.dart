import 'package:ct240_doan/apis/duan_api.dart';
import 'package:ct240_doan/components/appbar_component.dart';
import 'package:ct240_doan/components/drawer.dart';
import 'package:ct240_doan/components/folder_component.dart';
import 'package:ct240_doan/components/model_component.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:ct240_doan/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apis/api.dart';
import '../details/duan.dart';
import 'duan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final duanController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: DrawerComponent(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            AppBarComponent(scaffoldKey),
            SizedBox(height: AppLayout.getHeight(30)),
            Row(
              children: [
                Text(
                  "Gần đây",
                  style: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]),
                ),
                Expanded(child: Container()),
                Text("Tất cả",
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900])),
              ],
            ),
            SizedBox(
              height: AppLayout.getHeight(10),
            ),
            SingleChildScrollView(
              child: StreamBuilder(
                  stream:
                      firebaseFirestore.collection(collectionDuAn).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final data = snapshot.data!.docs;
                      data.forEach((element) {});
                      return Container(
                        height: AppLayout.getHeight(150),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: AppLayout.getWidth(10),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.to(() => DuAnScreen());
                                },
                                child: ModelComponent());
                          },
                        ),
                      );
                    } else
                      return CircularProgressIndicator();
                  }),
            ),
            SizedBox(
              height: AppLayout.getHeight(10),
            ),
            Row(
              children: [
                Text("Sắp xếp theo",
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900])),
                Icon(
                  Icons.arrow_downward,
                  size: 15,
                  color: Colors.blue[900],
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                  height: AppLayout.getHeight(335),
                  child: StreamBuilder(
                      stream: firebaseFirestore
                          .collection(collectionDuAn)
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<DuAnDetail> listDuAn = [];
                        if (snapshot.hasData && snapshot.data != null) {
                          final dataDuAn = snapshot.data!.docs;
                          dataDuAn.forEach((element) {
                            listDuAn.add(DuAnDetail.fromSnapshot(element));
                          });
                          return ListView.builder(
                              itemCount: listDuAn.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DuAnScreen(),
                                        arguments: listDuAn[index]);
                                  },
                                  child: FolderComponent(
                                      listDuAn[index].tenDuAn,
                                      listDuAn[index].ngayTaoDuAn,
                                      listDuAn[index].type),
                                );
                              });
                        } else
                          return Container();
                      })),
            )
          ]),
        ),
        floatingActionButton: Container(
            width: AppLayout.getWidth(40),
            height: AppLayout.getHeight(40),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                          builder: (context, setStateForDialog) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          scrollable: true,
                          title: Center(
                            child: Text(
                              "Dự án mới",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(20),
                          content: Column(
                            children: [
                              SizedBox(
                                height: AppLayout.getHeight(45),
                                child: TextField(
                                  controller: duanController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10, left: 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide:
                                              BorderSide(color: Colors.blue)),
                                      hintText: "Nhập tên dự án mới",
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
                                    "Tạo dự án",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    final time = DateTime.now();
                                    String id=duanController.text.hashCode.toString();
                                    DuAnDetail duan = DuAnDetail(
                                        tenDuAn: duanController.text.toString(),
                                        ngayTaoDuAn:
                                            FormatLayout.formatTimeToString(
                                                time, 'dd/MM/yyyy'),type: "Dự Án", id: id);
                                    await DuAnAPI.createDuAn(duan);
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
                                    API.handleGoogleSignIn();
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Icon(Icons.add),
            )),
      ),
    );
  }
}