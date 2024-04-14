import 'package:ct240_doan/details/duan.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final MauDetail duAnDetail;

  final tenDuAn;
  const StatsWidget({
    super.key,
    required this.duAnDetail,
    required this.tenDuAn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buidStatistic(context, 'Tên mẫu', duAnDetail.tenMau),
          buidStatistic(context, 'Dự án', tenDuAn),
          buidStatistic(context, 'Ngày tạo', duAnDetail.ngayLayMau)
        ],
      ),
    );
  }

  Widget buidStatistic(BuildContext context, String text, String value) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      );
}
