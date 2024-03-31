import 'package:ct240_doan/details/duan.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/widgets/stats_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PanelWidget extends StatelessWidget {
  final MauDetail duAnDetail;
  final tenDuAn;
  final List<String> imagePaths;
  final VoidCallback onClickedPanel;
  final ScrollController controller;
  const PanelWidget({
    super.key,
    required this.duAnDetail,
    required this.onClickedPanel,
    required this.tenDuAn,
    required this.imagePaths,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatsWidget(
          duAnDetail: duAnDetail,
          tenDuAn: tenDuAn,
        ),
        Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white),
                child: ContentDetail()))
      ],
    );
  }

  Widget ContentDetail() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClickedPanel,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: buildContentDetails(duAnDetail),
        ),
      );
  Widget buildContentDetails(MauDetail duAnDetail) => SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 500,
                child: Center(child: TitleText('Thông tin chi tiết'))),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textContent('Địa điểm lấy mẫu: '),
                textContent(duAnDetail.diaDiem)
              ],
            ),
            const Text(
              'Mô tả',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              duAnDetail.moTa,
              style: const TextStyle(fontSize: 19),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Photos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Builder(builder: (BuildContext context) {
              return Wrap(
                spacing: 5,
                runSpacing: 5,
                children: imagePaths
                    .map(
                      (path) => GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Image.asset(
                                      path,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 230,
                          width: 170,
                          padding: const EdgeInsets.only(right: 5),
                          child: Image.asset(
                            path,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            })
          ],
        ),
      );
  Widget TitleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget textContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 20),
    );
  }
}
