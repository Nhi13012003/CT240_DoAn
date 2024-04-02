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
import 'package:ionicons/ionicons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// class SampleDetail extends StatefulWidget {
//   const SampleDetail({super.key});

//   @override
//   State<SampleDetail> createState() => _SampleDetailState();
// }

// class _SampleDetailState extends State<SampleDetail> {
//   var tenDuAn;
//   late DuAnDetail sampleDetail;
//   @override
//   void initState() {
//     super.initState();
//     List<dynamic> argumentList = Get.arguments;
//     sampleDetail = argumentList[0];
//     tenDuAn = argumentList[1];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(
//               Ionicons.chevron_back_outline,
//               color: Colors.lightBlueAccent,
//               size: 32,
//             )),
//         leadingWidth: 100,
//       ),
//       body: Column(
//         children: [
//           Container(
//             alignment: Alignment.topLeft,
//             margin: const EdgeInsets.only(left: 10),
//             child: const Text(
//               'Chi tiết mẫu',
//               style: TextStyle(
//                   fontSize: 33,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 137, 202, 246)),
//             ),
//           ),
//           Row(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(left: 30),
//                 width: 40,
//                 height: 70,
//                 decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 163, 228, 243),
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Ionicons.chevron_back_outline),
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Center(
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     width: 370,
//                     height: 470,
//                     decoration: BoxDecoration(
//                         color: Colors.blue[50],
//                         border: Border.all(width: 1, color: Colors.grey)),
//                     child: Image.asset(
//                       'assets/C7N.jpg',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(right: 30),
//                 width: 40,
//                 height: 70,
//                 decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 163, 228, 243),
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Ionicons.chevron_forward_outline)),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.all(22),
//             margin: const EdgeInsets.only(top: 10),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Text(
//                   'Tên mẫu: ${sampleDetail.tenDuAn}',
//                   style: const TextStyle(fontSize: 22, color: Colors.grey),
//                 )),
//                 Expanded(
//                     child: Text(
//                   'Dự án: $tenDuAn',
//                   style: const TextStyle(fontSize: 22, color: Colors.grey),
//                 ))
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(22),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Text(
//                   'Loại: ${sampleDetail.type}',
//                   style: const TextStyle(fontSize: 22, color: Colors.grey),
//                 )),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(22),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Text(
//                   'Thời gian lấy mẫu: ${sampleDetail.ngayTaoDuAn}',
//                   style: const TextStyle(fontSize: 22, color: Colors.grey),
//                 )),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(22),
//             child: const Row(
//               children: [
//                 Expanded(
//                     child: Text(
//                   'Mô tả',
//                   style: TextStyle(fontSize: 22, color: Colors.grey),
//                 )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(
                TaoMauScreen(currentStream: null,),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.back(result: 'sampleDetail');
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: SlidingUpPanel(
          minHeight: 170,
          maxHeight: MediaQuery.of(context).size.height - 400,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          controller: panelController,
          color: Colors.transparent,
          backdropTapClosesPanel: true,
          body: PageView(
            children: imagePaths
                .map((path) => Image.asset(
                      path,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            onPageChanged: (index) => setState(() {
              this.index = index;
            }),
          ),
          panelBuilder: (ScrollController scrollController) => PanelWidget(
            duAnDetail: sampleDetail[countIndex],
            onClickedPanel: panelController.open,
            tenDuAn: tenDuAn,
            imagePaths: imagePaths,
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
        ),
      ),
    );
  }
}
