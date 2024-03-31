import 'package:ct240_doan/details/mau.dart';

class MauAPI {
  static Future<void> createMau(MauDetail mauDetail, stream) async {
    await stream.add(mauDetail.toJson());
  }
}
