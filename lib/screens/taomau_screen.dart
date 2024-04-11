import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/apis/mau_api.dart';
import 'package:ct240_doan/components/imagepicker_dialog_component.dart';
import 'package:ct240_doan/controllers/imagepicker_controller.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:ct240_doan/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import '../details/img_mau.dart';
import '../patterns/usersingleton.dart';

class TaoMauScreen extends StatefulWidget {
  CollectionReference<Map<dynamic, dynamic>>? currentStream;

  TaoMauScreen({super.key, required this.currentStream});

  @override
  State<StatefulWidget> createState() {
    return TaoMauScreenState();
  }
}

class TaoMauScreenState extends State<TaoMauScreen> {
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
  @override
  void initState() {
    super.initState();
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
                    "Tạo mẫu mới",
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
                                      border: Border.all(color: Colors.blue)),
                                  height: AppLayout.getHeight(150),
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: listAnh.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: AppLayout.getWidth(5),
                                            ),
                                            Text(
                                              index.toString(),
                                              style: TextStyle(
                                                  color: Colors.purple[900]),
                                            ),
                                            SizedBox(
                                              width: AppLayout.getWidth(5),
                                            ),
                                            const Icon(
                                              Icons.image_outlined,
                                              color: Colors.deepPurple,
                                            ),
                                            SizedBox(
                                              width: AppLayout.getWidth(5),
                                            ),
                                            Expanded(
                                              child: Text(
                                                listAnh[index].tenAnh,
                                                style: const TextStyle(
                                                    color: Colors.deepPurple),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: AppLayout.getWidth(10),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await Get.dialog(
                                          ImagePickerDialog(context));
                                      setState(() {
                                        if (imagePickerController
                                                    .imgPath.value !=
                                                '' &&
                                            imagePickerController
                                                    .imgName.value !=
                                                '') {
                                          listAnh.add(ImageMau(
                                              tenAnh: imagePickerController
                                                  .imgName.value,
                                              pathAnh: imagePickerController
                                                  .imgPath.value));
                                        }
                                      });
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
                                if (_formKey.currentState!.validate()) {
                                  String id =
                                      tenMauController.text.hashCode.toString();
                                  List<Map<String, String>> listPath = [];
                                  for (int i = 0; i < listAnh.length; i++) {
                                    String path =
                                        await imagePickerController.StoreImage(
                                            tenMauController.text.toString(),
                                            listAnh[i].tenAnh,
                                            listAnh[i].pathAnh);
                                    listPath.add({
                                      "index": i.toString(),
                                      "url": path,
                                    });
                                  }
                                  MauDetail mauDetail = MauDetail(
                                      id,
                                      UserSingleton.email,
                                      tenMauController.text.toString(),
                                      ngaylayMauController.text.toString(),
                                      listPath,
                                      diaDiemController.text.toString(),
                                      loaiMauController.text.toString(),
                                      moTaController.text.toString(),
                                      ghiChuController.text.toString());
                                  await MauAPI.createMau(
                                      mauDetail, widget.currentStream);
                                  widget.currentStream!.doc(id).update({
                                    "ListHinhAnh":
                                        FieldValue.arrayUnion(listPath)
                                  });
                                  Get.back();
                                }
                              },
                              child: Text(
                                "Tạo mẫu",
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
