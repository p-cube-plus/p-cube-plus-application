import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/premission_manager/permission_manager.dart';
import 'package:presentation/ui/executive/executive_main_page.dart';
import 'package:presentation/ui/home/home_page_event.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_page.dart';
import 'package:presentation/widgets/default_refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'home_attendance/home_attendance.dart';
import 'home_page_viewmodel.dart';
import 'home_schedule/home_schedule.dart';
import 'home_upcomming/home_upcomming_schedule.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageViewModel(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage>
    with ViewModel<HomePageViewModel>, AutomaticKeepAliveClientMixin {
  Key _refreshKey = UniqueKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {});
  }

  void setListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case HomePageEventShowToast():
          Fluttertoast.showToast(msg: event.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PermissionManager().checkOnBoardingPermission();
    super.build(context);
    return DefaultPage(
      key: _refreshKey,
      title: "홈",
      action: watchWidget((viewModel) => viewModel.isExecutive,
          (context, isExecutive) {
        if (isExecutive) {
          return GestureDetector(
            child: SvgPicture.asset(asset.executiveHome),
            onTap: () => _navigateToExecutivePage(),
          );
        } else {
          return const SizedBox();
        }
      }),
      content: DefaultRefreshIndicator(
        onRefresh: () async {
          setState(() {
            _refreshKey = UniqueKey();
          });
        },
        child: const DefaultContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAttendence(),
              SizedBox(height: 40),
              HomeUpcommingSchedule(),
              HomeSchedule(),
            ],
          ),
        ),
      ),
      //floatingActionButton: FloatingBarcodeButton(),
    );
  }

  _navigateToExecutivePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecutiveMainPage(),
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
