import 'package:ct240_doan/details/duan.dart';
import 'package:ct240_doan/details/mau.dart';
import 'package:ct240_doan/screens/duan_screen.dart';
import 'package:ct240_doan/screens/edit_profile.dart';
import 'package:ct240_doan/screens/taomau_screen.dart';
import 'package:ct240_doan/widgets/bottom_navigation_bar_widgets.dart';
import 'package:ct240_doan/widgets/panel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SampleDetail extends StatefulWidget {
  const SampleDetail({super.key});

  @override
  State<SampleDetail> createState() => _SampleDetailState();
}

class _SampleDetailState extends State<SampleDetail> {
  List<MauDetail> sampleDetail = [];

  var tenDuAn;

  late List<String> imagePaths;
  final panelController = PanelController();
  int index = 0;
  late bool checkOpen;
  var countIndex;

  @override
  void initState() {
    super.initState();
    List<dynamic> argumentList = Get.arguments;
    countIndex = argumentList[0];

    sampleDetail = argumentList[1];
    tenDuAn = argumentList[2];

    imagePaths = [
      'assets/C7N.jpg',
      'assets/flashscreen.jpg',
      'assets/Photo1.jpg',
      'assets/Photo1.jpg',
      'assets/Photo1.jpg',
      'assets/Photo1.jpg',
      'assets/Photo2.jpg'
    ];
    printUrls();
    checkOpen = false;
  }

  void printUrls() {
    // Kiểm tra nếu listHinhAnh là null hoặc rỗng
    if (sampleDetail.isNotEmpty &&
        sampleDetail[countIndex].listHinhAnh.isNotEmpty) {
      print("Danh sách URL trong listHinhAnh:");
      for (final imageMap in sampleDetail[countIndex].listHinhAnh) {
        print(imageMap['url']);
      }
    } else {
      print("listHinhAnh rỗng hoặc null.");
    }
  }

  void OpenOrClosePanel() {
    checkOpen = !checkOpen;
    if (checkOpen == true) {
      panelController.open();
    } else {
      panelController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Ionicons.create_outline,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(
                TaoMauScreen(
                  currentStream: null,
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.back(result: 'sampleDetail');
              },
              icon: const Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.2,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          controller: panelController,
          color: Colors.transparent,
          backdropTapClosesPanel: true,
          body: PageView(
            children: sampleDetail[countIndex]
                .listHinhAnh
                .map((imageMap) => CachedNetworkImage(
                      imageUrl: imageMap['url']!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))
                .toList(),
            onPageChanged: (index) => setState(() {
              this.index = index;
            }),
          ),
          panelBuilder: (ScrollController scrollController) => PanelWidget(
            duAnDetail: sampleDetail[countIndex],
            onClickedPanel: OpenOrClosePanel,
            tenDuAn: tenDuAn,
            controller: scrollController,
          ),
        ),
        bottomNavigationBar: BottomNavigationbarWidget(
          onArrowBackPressed: () {
            setState(() {
              if (countIndex > 0) {
                countIndex--;
              }
            });
          },
          onArrowForwardPressed: () {
            setState(() {
              if (countIndex < sampleDetail.length - 1) {
                countIndex++;
              }
            });
          },
          currentIndex: countIndex,
          listLenght: sampleDetail.length,
        ),
      ),
    );
  }
}
