import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct240_doan/consts/firebase_const.dart';
import 'package:googleapis/compute/v1.dart';

import '../details/duan.dart';

class DuAnAPI
{
  static Future<void> createDuAn(DuAnDetail duan)async
  {
    try{
      await firebaseFirestore.collection(collectionDuAn).doc(duan.id).set(duan.toJson());
    }
    catch(e)
    {
      print(e);
    }
  }

}