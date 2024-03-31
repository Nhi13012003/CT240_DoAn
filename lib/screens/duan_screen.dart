import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/apis/api.dart';
import 'package:ct240_doan/apis/duan_api.dart';
import 'package:ct240_doan/components/folder_component.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:ct240_doan/details/duan.dart';
import 'package:ct240_doan/screens/taomau_screen.dart';
import 'package:ct240_doan/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apis/folder_api.dart';
import '../utils/app_layout.dart';

class DuAnScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DuAnScreenState();
  }
}

class DuAnScreenState extends State<DuAnScreen> {
  CollectionReference<Map<dynamic, dynamic>>? currentStream;
  DuAnDetail duAnDetail = Get.arguments;
  List<String> listFolder = [];
  List<DuAnDetail> listId = [];
  final folderController = TextEditingController();
  @override
  void initState() {
    super.initState();
    currentStream=firebaseFirestore.collection(collectionDuAn).doc(duAnDetail.id).
        collection(duAnDetail.tenDuAn);
    listFolder.add(duAnDetail.tenDuAn);
  }
  void updateStream()
  {
    listId.forEach((element) {
      setState(() {
        currentStream =currentStream!.doc(element.id).collection(element.tenDuAn);
      });
    });
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Text(
                    duAnDetail.tenDuAn,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: Container(
                child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    alignment:  Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: AppLayout.getHeight(30),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()
                            {
                              setState(() {
                                updateStream();
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(listFolder[index],
                                style: GoogleFonts.openSans(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Center(
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 10,
                            ),
                          );
                        },
                        itemCount: listFolder.length),
                  ),
                ),
                Divider(
                  color: Colors.blue[900],
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: AppLayout.getHeight(500),
                    child: StreamBuilder(
                      stream:currentStream!.snapshots(),
                      builder: (context,snapshot)
                      {
                        List<DuAnDetail> list=[];

                        if(snapshot.hasData&&snapshot.data!=null)
                          {
                            final dataDuAn = snapshot.data!.docs;
                            dataDuAn.forEach((element) {
                              list.add(DuAnDetail.fromSnapshot(element as DocumentSnapshot<Map<String, dynamic>>));
                            });
                            return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context,index)
                              {
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      listId.add(list[index]);

                                      listFolder.add(list[index].tenDuAn);
                                    });
                                    updateStream();
                                  },
                                  child: FolderComponent(list[index].tenDuAn,list[index].ngayTaoDuAn,
                                  list[index].type),
                                );
                              },
                            );
                          }
                        else return Container();
                      },
                    ),
                  ),
                ),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                scrollable: true,
                                title: Center(
                                  child: Text(
                                    "Thư mục mới",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(20),
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: AppLayout.getHeight(45),
                                      child: TextField(
                                        controller: folderController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 10, left: 10),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
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
                                          String id=folderController.text.hashCode.toString();
                                          final time = DateTime.now();
                                          DuAnDetail duan = DuAnDetail(
                                              tenDuAn: folderController.text
                                                  .toString(),
                                              ngayTaoDuAn: FormatLayout
                                                  .formatTimeToString(
                                                      time, 'dd/MM/yyyy'),
                                              type: 'Folder', id: id);
                                          await FolderAPI.createFolder(duAnDetail.id,duAnDetail.tenDuAn,duan,currentStream);
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
                    child: Icon(Icons.folder)),
                SpeedDialChild(
                    onTap: () {
                      Get.to(()=>TaoMauScreen(currentStream: currentStream,));
                    },
                    label: "Tạo mẫu",
                    child: Icon(Icons.file_copy))
              ],
            )));
  }
}
