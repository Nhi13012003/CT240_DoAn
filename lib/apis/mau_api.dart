import 'dart:isolate';

import 'package:ct240_doan/controllers/imagepicker_controller.dart';
import 'package:ct240_doan/details/img_mau.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:image_picker/image_picker.dart';

class MauAPI {
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  static Future<void> createMau(MauDetail mauDetail, stream) async {
    await stream.add(mauDetail.toJson());
  }


}
