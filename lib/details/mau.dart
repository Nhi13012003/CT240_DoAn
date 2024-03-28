import 'package:cloud_firestore/cloud_firestore.dart';

class MauDetail
{
  late String id;
  late String nguoiTaoMau;
  late String tenMau;
  late String ngayLayMau;
  late String diaDiem;
  late String loaiMau;
  late String moTa;
  late String ghiChu;

  MauDetail(
      this.id, this.nguoiTaoMau, this.tenMau, this.ngayLayMau,
      this.diaDiem, this.loaiMau, this.moTa, this.ghiChu);
  toJson()
  {
    return {
      "Id":id,
      "NguoiTaoMau":nguoiTaoMau,
      "TenMau":tenMau,
      "NgayLayMau":ngayLayMau,
      "DiaDiem":diaDiem,
      "LoaiMau":loaiMau,
      "MoTa":moTa,
      "GhiChu":ghiChu,
    };
  }
  MauDetail.fromJson(Map<dynamic,dynamic> json)
  {
    id = json["Id"].toString();
    nguoiTaoMau = json["NguoiTaoMau"].toString();
    tenMau = json["TenMau"].toString();
    ngayLayMau = json["MgayLayMau"].toString();
    diaDiem = json["DiaDiem"].toString();
    loaiMau = json["DiaDiem"].toString();
    moTa = json["MoTa"].toString();
    ghiChu = json["GhiChu"].toString();
  }
  factory MauDetail.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return MauDetail(
        data["Id"]==null?"":data["Id"],
        data["NguoiTaoMau"]==null?"":data["NguoiTaoMau"],
        data["TenMau"]==null?"":data["TenMau"],
        data["NgayLayMau"]==null?"":data["NgayLayMau"],
        data["DiaDiem"]==null?"":data["DiaDiem"],
        data["LoaiMau"]==null?"":data["LoaiMau"],
        data["MoTa"]==null?"":data["MoTa"],
        data["GhiChu"]==null?"":data["GhiChu"]);
  }
}