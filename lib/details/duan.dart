import 'package:cloud_firestore/cloud_firestore.dart';

class DuAnDetail {
  late String id;
  late String type;
  late String tenDuAn;
  late String ngayTaoDuAn;
  DuAnDetail(
      {required this.id,required this.tenDuAn, required this.ngayTaoDuAn, required this.type});
  toJson() {
    return {
      "Id": tenDuAn.hashCode.toString(),
      "TenDuAn": tenDuAn,
      "Type": type,
      "NgayTaoDuAn": ngayTaoDuAn
    };
  }

  DuAnDetail.fromJson(Map<dynamic, dynamic> json) {
    type = json["Type"].toString();
    id = json["Id"].toString();
    tenDuAn = json["TenDuAn"].toString();
    ngayTaoDuAn = json["NgayTaoDuAn"].toString();
  }
  factory DuAnDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return DuAnDetail(
        tenDuAn: data["TenDuAn"] == null ? "" : data["TenDuAn"],
        ngayTaoDuAn: data["NgayTaoDuAn"] == null ? "" : data["NgayTaoDuAn"],
        type: data["Type"] == null ? "" : data["Type"],
        id: data["Id"]==null? "": data["Id"]);
  }
}
