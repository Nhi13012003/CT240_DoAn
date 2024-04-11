import 'package:cloud_firestore/cloud_firestore.dart';

class DuAnDetail {
  late String id;
  late String type;
  late String tenDuAn;
  late String ngayTaoDuAn;
  late String userId;
  DuAnDetail(
      {required this.id,
      required this.tenDuAn,
      required this.ngayTaoDuAn,
      required this.type,
      required this.userId});
  toJson() {
    return {
      "Id": tenDuAn.hashCode.toString(),
      "TenDuAn": tenDuAn,
      "Type": type,
      "NgayTaoDuAn": ngayTaoDuAn,
      "UserId": userId,
    };
  }

  DuAnDetail.fromJson(Map<dynamic, dynamic> json) {
    type = json["Type"].toString();
    id = json["Id"].toString();
    tenDuAn = json["TenDuAn"].toString();
    ngayTaoDuAn = json["NgayTaoDuAn"].toString();
    userId = json["UserId"].toString();
  }
  factory DuAnDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return DuAnDetail(
        tenDuAn: data["TenDuAn"] ?? "",
        ngayTaoDuAn: data["NgayTaoDuAn"] ?? "",
        type: data["Type"] ?? "",
        id: data["Id"] ?? "",
        userId: data["UserId"] ?? "");
  }
}
