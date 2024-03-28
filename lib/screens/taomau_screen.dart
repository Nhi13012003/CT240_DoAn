import 'package:ct240_doan/components/imagepicker_dialog_component.dart';
import 'package:ct240_doan/controllers/imagepicker_controller.dart';
import 'package:ct240_doan/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TaoMauScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaoMauScreenState();
  }
}

class TaoMauScreenState extends State<TaoMauScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final tenMauController = TextEditingController();
  final ngaylayMauController = TextEditingController();
  final diaDiemController = TextEditingController();
  final loaiMauController = TextEditingController();
  final moTaController = TextEditingController();
  final ghiChuController = TextEditingController();
  final imagePickerController = Get.put(ImagePickerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> listPath = [];
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
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppLayout.getHeight(20),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: AppLayout.getHeight(30),
                            child: TextFormField(
                              controller: tenMauController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
                                  labelText: "Tên mẫu",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(15),
                          ),
                          Container(
                            height: AppLayout.getHeight(30),
                            child: TextFormField(
                              controller: ngaylayMauController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
                                  labelText: "Ngày lấy mẫu",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Container(
                            height: AppLayout.getHeight(30),
                            child: TextFormField(
                              controller: diaDiemController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
                                  labelText: "Địa điểm",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Container(
                            height: AppLayout.getHeight(30),
                            child: TextFormField(
                              controller: loaiMauController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 10),
                                  labelText: "Loại mẫu",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(20),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    height: AppLayout.getHeight(150),
                                    child: Obx(
                                      () => ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: imagePickerController
                                              .listPath.value.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Text(index.toString()),
                                                Icon(Icons.image),
                                                Expanded(
                                                  child: Text(
                                                    imagePickerController
                                                        .listPath.value[index],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    )),
                              ),
                              SizedBox(
                                width: AppLayout.getWidth(10),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.dialog(ImagePickerDialog(context));
                                    },
                                    child: CircleAvatar(
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
                              decoration: InputDecoration(
                                  labelText: "Mô tả",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  )),
                            ),
                          ),
                          Container(
                            child: TextField(
                              controller: ghiChuController,
                              maxLength: 150,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  labelText: "Ghi chú",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  )),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[900]),
                              onPressed: () {},
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
}
