

import 'dart:io';

import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  static ImagePickerController get instance => Get.find();
  RxString imgPath = ''.obs;
  RxString imgName = ''.obs;
  Future<String> StoreImage(String tenMau,String tenAnh,String path) async
  {
  Reference referenceRoot=firebaseStorage.ref();
  Reference referenceImage=referenceRoot.child(tenMau);
  Reference referenceStoreImage=referenceImage.child(tenAnh);
  try
      {
      await referenceStoreImage.putFile(File(path));
      final url = await referenceStoreImage.getDownloadURL();
      return url;
      }
      catch(e)
    {
      return "";
    }
  }
}
