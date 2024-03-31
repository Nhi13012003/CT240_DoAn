import 'package:ct240_doan/controllers/imagepicker_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

Widget ImagePickerDialog(context) {
  final imagePickerController = Get.put(ImagePickerController());

  var listTitle = ["máy ảnh", "thư viện", "hủy"];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_actual_outlined,
    Icons.cancel_outlined
  ];
  imagePickerController.imgPath.value='';
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () async {
                    switch (index) {
                      case 0:
                        PickedFile? imageFile;
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        break;

                      case 1:
                        PickedFile? imageFile;
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile != null)
                        {
                          imagePickerController.imgPath.value=pickedFile.path;
                          imagePickerController.imgName.value=pickedFile.name;
                        }
                        Get.back();
                        break;
                      case 2:
                        Get.back();
                        break;
                    }
                  },
                  leading: Icon(icons[index]),
                  title: Text(listTitle[index]),
                );
              })
        ],
      ),
    ),
  );
}
