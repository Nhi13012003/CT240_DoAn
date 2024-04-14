import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/apis/duan_api.dart';
import 'package:ct240_doan/components/appbar_component.dart';
import 'package:ct240_doan/components/drawer.dart';
import 'package:ct240_doan/components/folder_component.dart';
import 'package:ct240_doan/components/model_component.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:ct240_doan/details/userData.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:ct240_doan/utils/format.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;
  UserDataDetail? userData;
  bool ngayGanNhat = true;
  List<DuAnDetail> listDuAn = [];

  @override
  void initState() {
    listDuAn = [];
    super.initState();
    getCurrentUser(); // Lấy dữ liệu của currentUser khi initState được gọi
  }

  Future<void> getCurrentUser() async {
    currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .get();
      userData = UserDataDetail.fromSnapshot(userDataSnapshot);
      setState(() {});
    }
  }

  Future<void> updateProjectCounter(int count) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(currentUser?.uid).update({'projectCounter': count});
    setState(() {
      userData!.projectCounter = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: DrawerComponent(
          userDataDetail: userData,
          currentUser: currentUser,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      for (var element in data) {}
                      return SizedBox(
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
                                  Get.to(() => const DuAnScreen());
                                },
                                child: ModelComponent());
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
            SizedBox(
              height: AppLayout.getHeight(10),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  listDuAn = List.from(SortDate(ngayGanNhat, listDuAn));
                  ngayGanNhat = !ngayGanNhat;
                });
              },
              child: Row(
                children: [
                  Text("Sắp xếp theo ngày",
                      style: GoogleFonts.openSans(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900])),
                  Icon(
                    ngayGanNhat ? Icons.arrow_downward : Icons.arrow_outward,
                    size: 15,
                    color: Colors.blue[900],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                  height: AppLayout.getHeight(335),
                  child: StreamBuilder(
                      stream: firebaseFirestore
                          .collection(collectionDuAn)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          final dataDuAn = snapshot.data!.docs;
                          listDuAn = [];
                          if (listDuAn.isEmpty) {
                            for (var element in dataDuAn) {
                              listDuAn.add(DuAnDetail.fromSnapshot(element));
                            }
                          }
                          return ListView.builder(
                              itemCount: listDuAn.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => const DuAnScreen(),
                                        arguments: listDuAn[index]);
                                  },
                                  child: FolderComponent(
                                      context,
                                      listDuAn[index].tenDuAn,
                                      listDuAn[index].ngayTaoDuAn,
                                      listDuAn[index].type,
                                      listDuAn[index].id),
                                );
                              });
                        } else {
                          return Container();
                        }
                      })),
            )
          ]),
        ),
        floatingActionButton: SizedBox(
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
                                  controller: duanController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 10, left: 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.blue)),
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
                                    late int count =
                                        userData!.projectCounter + 1;
                                    final time = DateTime.now();
                                    String id =
                                        duanController.text.hashCode.toString();
                                    DuAnDetail duan = DuAnDetail(
                                        tenDuAn: duanController.text.toString(),
                                        ngayTaoDuAn:
                                            FormatLayout.formatTimeToString(
                                                time, 'dd/MM/yyyy'),
                                        type: "DuAn",
                                        id: id,
                                        userId: currentUser!.uid);
                                    await DuAnAPI.createDuAn(duan);
                                    updateProjectCounter(count);
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
              },
              child: const Icon(Icons.add),
            )),
      ),
    );
  }

  List<DuAnDetail> SortDate(bool ganToiXa, List<DuAnDetail> listDuAn) {
    List<DuAnDetail> listTheoNgay = List.from(listDuAn);
    listTheoNgay.sort((a, b) {
      DateTime dateA =
          FormatLayout.stringToDateTime(a.ngayTaoDuAn, "dd/MM/yyyy");
      DateTime dateB =
          FormatLayout.stringToDateTime(b.ngayTaoDuAn, "dd/MM/yyyy");
      return ganToiXa ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
    return listTheoNgay;
  }
}
