import 'dart:io';

import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../firebase_options.dart';

class ImagePickerController extends GetxController {
  static ImagePickerController get instance => Get.find();
  RxString imgPath = ''.obs;
  RxString imgName = ''.obs;
  static Future<String> StoreImage(
      String tenMau, String tenAnh, String path) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    Reference referenceRoot = firebaseStorage.ref();
    Reference referenceImage = referenceRoot.child(tenMau);
    Reference referenceStoreImage = referenceImage.child(tenAnh);
    try {
      await referenceStoreImage.putFile(File(path));
      final url = await referenceStoreImage.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
