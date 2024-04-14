import 'package:cloud_firestore/cloud_firestore.dart';

class MauDetail {
  late String id;
  late String nguoiTaoMau;
  late String tenMau;
  late List<Map<String, String>> listHinhAnh;
  late String ngayLayMau;
  late String diaDiem;
  late String loaiMau;
  late String moTa;
  late String ghiChu;

  MauDetail(this.id, this.nguoiTaoMau, this.tenMau, this.ngayLayMau,
      this.listHinhAnh, this.diaDiem, this.loaiMau, this.moTa, this.ghiChu);

  toJson() {
    return {
      "Id": id,
      "NguoiTaoMau": nguoiTaoMau,
      "TenMau": tenMau,
      "NgayLayMau": ngayLayMau,
      "ListHinhAnh": listHinhAnh,
      "DiaDiem": diaDiem,
      "LoaiMau": loaiMau,
      "MoTa": moTa,
      "GhiChu": ghiChu,
    };
  }

  MauDetail.fromJson(Map<dynamic, dynamic> json) {
    id = json["Id"].toString();
    nguoiTaoMau = json["NguoiTaoMau"].toString();
    tenMau = json["TenMau"].toString();
    ngayLayMau = json["NgayLayMau"].toString();
    listHinhAnh = (json["ListHinhAnh"] as List<dynamic>)
        .map((item) => Map<String, String>.from(item))
        .toList(); // Initialize as empty list if null

    diaDiem = json["DiaDiem"].toString();
    loaiMau = json["LoaiMau"].toString();
    moTa = json["MoTa"].toString();
    ghiChu = json["GhiChu"].toString();
  }

  factory MauDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    List<Map<String, String>> listHinhAnh = [];
    if (data["ListHinhAnh"] != null) {
      List<dynamic> rawList = data["ListHinhAnh"];
      listHinhAnh =
          rawList.map((item) => Map<String, String>.from(item)).toList();
    }

    return MauDetail(
      data["Id"] ?? "",
      data["NguoiTaoMau"] ?? "",
      data["TenMau"] ?? "",
      data["NgayLayMau"] ?? "",
      listHinhAnh,
      data["DiaDiem"] ?? "",
      data["LoaiMau"] ?? "",
      data["MoTa"] ?? "",
      data["GhiChu"] ?? "",
    );
  }
}
