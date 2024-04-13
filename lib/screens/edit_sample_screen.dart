import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/apis/mau_api.dart';
import 'package:ct240_doan/components/imagepicker_dialog_component.dart';
import 'package:ct240_doan/components/select_image_sample.dart';
import 'package:ct240_doan/controllers/imagepicker_controller.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/screens/sample_detail.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:ct240_doan/utils/format.dart';
import 'package:ct240_doan/utils/pickAvatar.dart';
import 'package:ct240_doan/widgets/full_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:ionicons/ionicons.dart';
import '../details/img_mau.dart';
import '../patterns/usersingleton.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditSampleScreen extends StatefulWidget {
  CollectionReference<Map<dynamic, dynamic>>? currentStream;
  late MauDetail sampleDetail;
  String idMau;

  EditSampleScreen({
    super.key,
    required this.currentStream,
    required this.sampleDetail,
    required this.idMau,
  });

  @override
  State<StatefulWidget> createState() {
    return EditSampleScreenState();
  }
}

class EditSampleScreenState extends State<EditSampleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final tenMauController = TextEditingController();
  final ngaylayMauController = TextEditingController();
  final diaDiemController = TextEditingController();
  final loaiMauController = TextEditingController();
  final moTaController = TextEditingController();
  final ghiChuController = TextEditingController();
  final imagePickerController = Get.put(ImagePickerController());
  List<ImageMau> listAnh = [];
  List<String> listName = [];
  UserSingleton userSingleton = UserSingleton();
  Uint8List image = Uint8List(0);
  var imageUrl;

  @override
  void initState() {
    super.initState();
    tenMauController.text = widget.sampleDetail.tenMau;
    ngaylayMauController.text = widget.sampleDetail.ngayLayMau;
    diaDiemController.text = widget.sampleDetail.diaDiem;
    loaiMauController.text = widget.sampleDetail.loaiMau;
    moTaController.text = widget.sampleDetail.moTa;
    ghiChuController.text = widget.sampleDetail.ghiChu;
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
                    "Chỉnh sửa mẫu",
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppLayout.getHeight(20),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vui lòng không bỏ trống";
                                }
                                return null;
                              },
                              controller: tenMauController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.content_copy_outlined,
                                    color: Colors.blue[900],
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 5, left: 10, top: 5),
                                  labelText: "Tên mẫu",
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[900] ??
                                            Colors.deepPurple),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(15),
                          ),
                          InkWell(
                            onTap: () {
                              selectedDate(context, ngaylayMauController);
                            },
                            child: TextFormField(
                                enabled: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Vui lòng chọn ngày";
                                  }
                                  return null;
                                },
                                controller: ngaylayMauController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_month_rounded,
                                      color: Colors.blue[900],
                                    ),
                                    prefixIconColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => states.contains(
                                                    MaterialState.focused)
                                                ? Colors.deepPurple
                                                : Colors.grey),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 5, left: 10, top: 5),
                                    labelText: "Ngày lấy mẫu",
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Colors.blue ?? Colors.deepPurple),
                                    ))),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Container(
                            child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Vui lòng nhập địa chỉ";
                                  }
                                  return null;
                                },
                                controller: diaDiemController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 5, left: 10, top: 5),
                                    labelText: "Địa điểm",
                                    prefixIcon: Icon(Icons.map_rounded,
                                        color: Colors.blue[900]),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue ??
                                                Colors.deepPurple)))),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Container(
                            child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Vui lòng nhập loại mẫu";
                                  }
                                  return null;
                                },
                                controller: loaiMauController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.category_outlined,
                                        color: Colors.blue[900]),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 5, left: 10, top: 5),
                                    labelText: "Loại mẫu",
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)))),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                  ),
                                  height: AppLayout.getHeight(150),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: widget.sampleDetail.listHinhAnh
                                          .asMap()
                                          .entries
                                          .map(
                                        (entry) {
                                          final int index = entry.key;
                                          final Map<String, String> path =
                                              entry.value;
                                          return Stack(
                                            // Wrap with Stack for layering
                                            children: [
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FullImageView(
                                                      initialIndex: index,
                                                      imageUrls: widget
                                                          .sampleDetail
                                                          .listHinhAnh,
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.16,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.21,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  child: CachedNetworkImage(
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(), // Hiển thị indicator khi hình ảnh đang được tải
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    imageUrl: path['url']!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // Position the 'x' button
                                                top: 0,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      widget.sampleDetail
                                                          .listHinhAnh
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: const Icon(
                                                      Ionicons.close_outline),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppLayout.getWidth(10),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Uint8List? img =
                                          await pickImage(ImageSource.gallery);
                                      // ignore: unnecessary_null_comparison
                                      if (img != null) {
                                        firebase_storage.Reference ref =
                                            firebase_storage
                                                .FirebaseStorage.instance
                                                .ref()
                                                .child('avatars')
                                                .child(
                                                    '${DateTime.now().millisecondsSinceEpoch}.jpg');
                                        await ref.putData(img);
                                        imageUrl = await ref.getDownloadURL();
                                        setState(() {
                                          widget.sampleDetail.listHinhAnh.add({
                                            "index": widget
                                                .sampleDetail.listHinhAnh
                                                .toString(),
                                            "url": imageUrl,
                                          });
                                        });
                                      } else {
                                        print("Image selection cancelled");
                                      }
                                    },
                                    child: const CircleAvatar(
                                      child: Icon(Icons.camera),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Container(
                            child: TextField(
                              controller: moTaController,
                              maxLength: 150,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  labelText: "Mô tả",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ),
                          ),
                          Container(
                            child: TextField(
                              controller: ghiChuController,
                              maxLength: 150,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  labelText: "Ghi chú",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[900]),
                              onPressed: () async {
                                widget.sampleDetail.tenMau =
                                    tenMauController.text.toString();
                                widget.sampleDetail.ngayLayMau =
                                    ngaylayMauController.text.toString();
                                widget.sampleDetail.diaDiem =
                                    diaDiemController.text.toString();
                                widget.sampleDetail.loaiMau =
                                    loaiMauController.text.toString();
                                widget.sampleDetail.moTa =
                                    moTaController.text.toString();
                                widget.sampleDetail.ghiChu =
                                    ghiChuController.text.toString();
                                widget.currentStream
                                    ?.doc(widget.idMau)
                                    .update(widget.sampleDetail.toJson());
                                Get.back();
                              },
                              child: Text(
                                "Lưu",
                                style:
                                    GoogleFonts.openSans(color: Colors.white),
                              )),
                          SizedBox(
                            height: AppLayout.getHeight(10),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Future<void> selectedDate(BuildContext context, controller) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2002),
        lastDate: DateTime.now(),
        locale: const Locale('vi', "VN"));
    if (pickedDate != null) {
      controller.text = pickedDate.toString().split(" ")[0];
    }
  }
}
