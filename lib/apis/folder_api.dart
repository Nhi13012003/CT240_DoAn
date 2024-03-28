import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:googleapis/compute/v1.dart';

import '../details/duan.dart';

class FolderAPI {
  static Future<void> createFolder(String id,String tenDuAn, DuAnDetail duAnDetail,stream) async {
    try {
      stream.add(duAnDetail.toJson());
    } catch (e) {
      print(e);
    }
  }
}
