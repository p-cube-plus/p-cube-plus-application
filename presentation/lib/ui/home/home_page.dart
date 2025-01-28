import 'package:domain/common/extensions/future_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/beacon/beacon_scanner.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/premission_manager/permission_manager.dart';
import 'package:presentation/ui/executive/executive_main_page.dart';
import 'package:presentation/ui/home/home_rent/home_rent_widget.dart';
import 'package:presentation/widgets/default_content.dart';
import 'package:presentation/widgets/default_future_builder.dart';
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
    BeaconScanner().startScanning().getOrNull();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    PermissionManager().checkOnBoardingPermission();
    super.build(context);
    return DefaultPage(
      key: _refreshKey,
      title: "홈",
      action: DefaultFutureBuilder(
        fetchData: read(context).fetchIsExecutive(),
        showOnLoadedWidget: (context, isExecutive) {
          if (isExecutive) {
            return GestureDetector(
              child: SvgPicture.asset(
                asset.executiveHome,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.neutral40,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () => _navigateToExecutivePage(),
            );
          } else {
            return const SizedBox();
          }
        },
        showOnLoadingWidget: (context) => const SizedBox(),
        showOnErrorWidget: (error, trace) => const SizedBox(),
        handleError: (error, trace) {
          Fluttertoast.showToast(msg: "임원진 여부 확인에 실패했습니다!\n새로고침해주세요.");
        },
      ),
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
              SizedBox(height: 48),
              HomeRentWidget(),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingBarcodeButton(),
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

class FloatingBarcodeButton extends StatelessWidget {
  FloatingBarcodeButton({super.key});

  final imagePicker = ImagePicker();
  final barcodeScanner =
      BarcodeScanner(formats: [BarcodeFormat.ean13, BarcodeFormat.ean8]);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => startBarcodeScan(),
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.primary80.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          asset.scan,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          width: 36,
          height: 36,
        ),
      ),
    );
  }

  Future startBarcodeScan() async {
    Fluttertoast.showToast(msg: "바코드를 찍어주세요.");
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final inputImage = InputImage.fromFilePath(pickedFile.path);
    final barcode = (await barcodeScanner.processImage(inputImage)).firstOrNull;
    if (barcode == null) {
      Fluttertoast.showToast(msg: "바코드 인식에 실패했습니다.");
      return;
    }

    Fluttertoast.showToast(msg: "${barcode.rawValue}");
  }
}
