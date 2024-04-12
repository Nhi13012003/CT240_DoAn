import 'dart:isolate';

import 'package:ct240_doan/controllers/imagepicker_controller.dart';
import 'package:ct240_doan/details/img_mau.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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

  static Future<List<Map<String, String>>> startisolateUploadImages(
      List<ImageMau> listAnh) async {
    List<Map<String, String>> listPath = [];
    List<Isolate> isolates = [];
    List<Future<void>> isolateFutures = [];
    //main isolate
    for (int i = 0; i < listAnh.length; i++) {
      ImageMau imageMau = ImageMau(
          tenMau: listAnh[i].tenMau,
          tenAnh: listAnh[i].tenAnh,
          pathAnh: listAnh[i].pathAnh);
      ReceivePort receivePort = ReceivePort();
      var rootToken  = RootIsolateToken.instance;
      isolates.add(
        await Isolate.spawn(uploadImage, [receivePort.sendPort, imageMau, rootToken]),
      );
      isolateFutures.add(
        receivePort.first.then((message) {
          listPath.add({
            "index": i.toString(),
            "url": message,
          });
        }),
      );
    }
    await Future.wait(isolateFutures);
    for (var isolate in isolates) {
      isolate.kill(priority: Isolate.immediate);
    }
    return listPath;
  }

  static void uploadImage(List<Object?> args) async {
    ImageMau imageMau = args[1] as ImageMau;
    SendPort sendPort = args[0] as SendPort;  
    var rootToken = args[2] as RootIsolateToken;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
    //new isolate
    try {
      String path = await ImagePickerController.StoreImage(
          imageMau.tenMau, imageMau.tenAnh, imageMau.pathAnh);
      sendPort.send(path);
    } catch (e) {
      print("error from $e");
    }
  }
}
