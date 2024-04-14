import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/apis/api.dart';
import 'package:ct240_doan/apis/duan_api.dart';
import 'package:ct240_doan/components/folder_component.dart';
import 'package:ct240_doan/components/sample_components.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:ct240_doan/details/duan.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/screens/duan_screen.dart';
import 'package:ct240_doan/screens/sample_detail.dart';
import 'package:ct240_doan/screens/taomau_screen.dart';
import 'package:ct240_doan/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apis/folder_api.dart';
import '../utils/app_layout.dart';

class PersonalProjectList extends StatefulWidget {
  const PersonalProjectList({super.key});

  @override
  State<StatefulWidget> createState() {
    return PersonalProjectListState();
  }
}

class PersonalProjectListState extends State<PersonalProjectList> {
  CollectionReference<Map<dynamic, dynamic>>? currentStream;
  CollectionReference<Map<dynamic, dynamic>>? newStream;
  String UserId = Get.arguments;
  List<String> listFolder = [];
  List<DuAnDetail> listId = [];
  List<DuAnDetail> listProject = [];

  final folderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDuAnDetailList();
  }

  Future<void> _initDuAnDetailList() async {
    try {
      // Lấy danh sách dự án từ Firestore
      final QuerySnapshot<
          Map<String,
              dynamic>> projectsSnapshot = await FirebaseFirestore.instance
          .collection(
              collectionDuAn) // Thay 'du_an_collection' bằng tên của collection trong Firestore của bạn
          .where('UserId', isEqualTo: UserId)
          .get();

      // Chuyển kết quả truy vấn thành danh sách dự án
      final List<DuAnDetail> projects = projectsSnapshot.docs.map((doc) {
        return DuAnDetail.fromJson(doc
            .data()); // Giả sử bạn có hàm fromJson để tạo đối tượng DuAnDetail từ dữ liệu Firestore
      }).toList();

      // Cập nhật danh sách dự án trong trạng thái
      setState(() {
        listProject = projects;
      });
    } catch (e) {
      print('Error loading projects: $e');
    }
  }

  void updateStream() {
    for (var element in listId) {
      setState(() {
        currentStream =
            currentStream!.doc(element.id).collection(element.tenDuAn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Text(
                    "Danh sách dự án",
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                          height: AppLayout.getHeight(335),
                          child: StreamBuilder(
                              stream: firebaseFirestore
                                  .collection(collectionDuAn)
                                  .where('UserId', isEqualTo: UserId)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<DuAnDetail> listDuAn = [];
                                if (snapshot.hasData && snapshot.data != null) {
                                  final dataDuAn = snapshot.data!.docs;
                                  for (var element in dataDuAn) {
                                    listDuAn
                                        .add(DuAnDetail.fromSnapshot(element));
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
                  ],
                )),
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.add_event,
              children: [
                SpeedDialChild(
                    onTap: () {
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
                                    "Thư mục mới",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: AppLayout.getHeight(45),
                                      child: TextField(
                                        controller: folderController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 10, left: 10),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                    color: Colors.blue)),
                                            hintText: "Nhập tên thư mục mới",
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
                                                AppLayout.getScreenWidth() *
                                                    0.7,
                                                AppLayout.getHeight(30))),
                                        child: Text(
                                          "Tạo thư mục mới",
                                          style: GoogleFonts.openSans(
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          String id = folderController
                                              .text.hashCode
                                              .toString();
                                          final time = DateTime.now();
                                          DuAnDetail duan = DuAnDetail(
                                              tenDuAn: folderController.text
                                                  .toString(),
                                              ngayTaoDuAn: FormatLayout
                                                  .formatTimeToString(
                                                      time, 'dd/MM/yyyy'),
                                              type: 'Folder',
                                              id: id,
                                              userId: '');
                                          await FolderAPI.createFolder(
                                              "duAnDetail[0].id",
                                              "duAnDetail[0].tenDuAn",
                                              duan,
                                              currentStream);
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
                                                AppLayout.getScreenWidth() *
                                                    0.7,
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
                    label: "Tạo thư mục",
                    child: const Icon(Icons.folder)),
                SpeedDialChild(
                    onTap: () {
                      Get.to(() => TaoMauScreen(
                            currentStream: currentStream,
                          ));
                    },
                    label: "Tạo mẫu",
                    child: const Icon(Icons.file_copy))
              ],
            )));
  }
}
