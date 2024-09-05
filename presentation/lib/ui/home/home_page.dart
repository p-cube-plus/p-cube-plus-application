import 'package:flutter/material.dart';
import 'package:presentation/ui/home/home_schedule/home_schedule_viewmodel.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_refresh_indicator.dart';
import 'package:provider/provider.dart';

import 'home_attendance/home_attendance.dart';
import 'home_attendance/home_attendnace_viewmodel.dart';
import 'home_schedule/home_schedule.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeAttendnaceViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScheduleViewmodel()),
      ],
      child: DefaultFutureBuilder(
        fetchData: Future.wait([
          context.read<HomeAttendnaceViewModel>().fetchData(),
          context.read<HomeScheduleViewmodel>().fetchData(),
        ]),
        showOnLoadedWidget: (_) {
          return DefaultRefreshIndicator(
            onRefresh: Future.wait([
              context.read<HomeAttendnaceViewModel>().refreshData(),
              context.read<HomeScheduleViewmodel>().refreshData(),
            ]),
            child: const DefaultPage(
              title: "홈",
              content: DefaultContent(
                child: Column(
                  children: [
                    HomeAttendence(),
                    HomeSchedule(),
                  ],
                ),
              ),
              //floatingActionButton: FloatingBarcodeButton(),
            ),
          );
        },
        showOnErrorWidget: (error, trace) {
          return const SizedBox();
        },
        handleError: (error, trace) {
          // 오류 처리
        },
      ),
    );
  }
}

// class FloatingBarcodeButton extends StatefulWidget {
//   @override
//   _FloatingBarcodeButton createState() => _FloatingBarcodeButton();
// }

// class _FloatingBarcodeButton extends State<FloatingBarcodeButton> {
//   String _platformVersion = 'Unknown';
//   String qrcode = 'Unknown';

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     String platformVersion;
//     try {
//       platformVersion = await Scan.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("code: $qrcode");
//     return SizedBox(
//       width: 64,
//       height: 64,
//       child: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) {
//             return ScanPage();
//           }));
//         },
//         elevation: 7.68,
//         focusElevation: 7.68,
//         hoverElevation: 7.68,
//         disabledElevation: 7.68,
//         highlightElevation: 7.68,
//         child: Padding(
//           padding: EdgeInsets.all(14),
//           child: Image.asset(
//             "assets/images/scan.png",
//           ),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//     );
//   }
// }
