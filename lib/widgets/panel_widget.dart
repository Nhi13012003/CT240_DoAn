import 'package:ct240_doan/details/duan.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/widgets/full_screen_widget.dart';
import 'package:ct240_doan/widgets/stats_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:ionicons/ionicons.dart';

class PanelWidget extends StatelessWidget {
  final MauDetail duAnDetail;
  final tenDuAn;

  final VoidCallback onClickedPanel;
  final ScrollController controller;
  const PanelWidget({
    super.key,
    required this.duAnDetail,
    required this.onClickedPanel,
    required this.tenDuAn,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClickedPanel,
          child: StatsWidget(
            duAnDetail: duAnDetail,
            tenDuAn: tenDuAn,
          ),
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

  Widget ContentDetail() => Container(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: buildContentDetails(duAnDetail),
        ),
      );
  Widget buildContentDetails(MauDetail duAnDetail) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 500,
            child: GestureDetector(
                onTap: onClickedPanel,
                child: const Center(child: Icon(Ionicons.reorder_two_outline))),
          ),
          SizedBox(
            width: 500,
            child: Center(child: TitleText('Thông tin chi tiết')),
          ),
          const SizedBox(height: 20.0), // Add spacing between title and content

          // Scrollable content within SingleChildScrollView
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleText('Địa điểm lấy mẫu: '),
                      textContent(duAnDetail.diaDiem),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Người tạo: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        duAnDetail.nguoiTaoMau,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Mô tả',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    duAnDetail.moTa,
                    style: const TextStyle(fontSize: 19),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Hình ảnh',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12.0),
                  Builder(
                    builder: (context) {
                      return Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: duAnDetail.listHinhAnh.asMap().entries.map(
                          (entry) {
                            final int index = entry.key;
                            final Map<String, String> path = entry.value;
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullImageView(
                                    initialIndex: index,
                                    imageUrls: duAnDetail.listHinhAnh,
                                  ),
                                ),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.25,
                                padding: const EdgeInsets.only(right: 5.0),
                                child: CachedNetworkImage(
                                  imageUrl: path['url']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleText('Ghi chú'),
                  Text(
                    duAnDetail.ghiChu,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      );
  Widget TitleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget textContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 18),
    );
  }
}
