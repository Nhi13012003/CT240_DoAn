import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  static ImagePickerController get instance => Get.find();
  RxList<dynamic> listPath = [].obs;
}
