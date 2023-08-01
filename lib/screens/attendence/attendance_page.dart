import 'dart:async';
import 'dart:io' show Platform;
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/common/list_divider.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/common/default_alert.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';
import '../fee/fee_page.dart';

class AttendancePage extends StatefulWidget {
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage>
    with WidgetsBindingObserver {
  bool _isInForeground = true;
  String? _result;
  var tempText = "출석하기";
  DateTime startTime = DateTime(2023, 08, 01, 20);
  DateTime endTime = DateTime(2023, 08, 01, 21);
  late DateTime lateTime = endTime.add(Duration(minutes: 15));
  late Image curImage = _getImage(FeeStateType.None, 64.0);

  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    BeaconsPlugin.stopMonitoring();
    beaconEventsController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _getImage(type, size) {
    if (type == FeeStateType.Done)
      return Image.asset("assets/images/positive.png",
          width: size, height: size);
    else if (type == FeeStateType.Late)
      return Image.asset("assets/images/late.png", width: size, height: size);
    else if (type == FeeStateType.Due)
      return Image.asset("assets/images/negative.png",
          width: size, height: size);
    else if (type == FeeStateType.Wait)
      return Image.asset("assets/images/off.png", width: size, height: size);
    else
      return Image.asset(
        "assets/images/none.png",
        width: size,
        height: size,
        scale: 0.6,
      );
  }

  Future<void> initPlatformState() async {
    await [
      Permission.location,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth
    ].request();

    // 명시적으로 권한부여 메시지를 띄움
    if (Platform.isAndroid) {
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "권한 요청", message: "해당 앱은 블루투스를 찾기 위해 위치 정보를 사용합니다.");

      await BeaconsPlugin.clearDisclosureDialogShowFlag(true);
    }

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        print("함수: ${call.method}");
        if (call.method == 'scannerReady') {
          print("준비됨");
        }
      });
    }

    print("모니터링 시작");
    BeaconsPlugin.setDebugLevel(2);

    // 스캔 시 함수 호출 세팅
    BeaconsPlugin.listenToBeacons(beaconEventsController);

    // UUID 변경 금지
    print("비콘 등록중");
    await BeaconsPlugin.addRegion(
            "Pcube+", "e2c56db5-dffb-48d2-b060-d0f5a71096e0")
        .then((value) => print("비콘 등록 완료"));

    // iBeacon은 Andriod에서 필요
    print("레이아웃 등록");
    await BeaconsPlugin.addBeaconLayoutForAndroid(
        "m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24");

    // foreground 세팅
    print("시간 세팅 등록");
    await BeaconsPlugin.setForegroundScanPeriodForAndroid(
        foregroundScanPeriod: 1100, foregroundBetweenScanPeriod: 100);

    // background 세팅
    BeaconsPlugin.setBackgroundScanPeriodForAndroid(
        backgroundScanPeriod: 1100, backgroundBetweenScanPeriod: 100);

    // 스캔 시 지속적으로 불리는 함수
    beaconEventsController.stream.listen(
        (data) async {
          if (data.isNotEmpty && _result == null) {
            setState(() {
              _result = data;
            });
            //await BeaconsPlugin.stopMonitoring();
          }

          if (!_isInForeground) {
            print("데이터 받음: " + data);
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });

    if (!mounted) return;
  }

  // 결과가 나올 때까지 100ms씩 기다림
  Future<void> waitForGetResult() async {
    while (_result == null) {
      await Future.delayed(Duration(milliseconds: 1000));
      print("결과 기다리는중..");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "출석체크",
      appbar: DefaultAppBar(),
      content: DefaultContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("오늘의 출석체크"),
            SizedBox(height: 8),
            RoundedBorder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("3월 28일 정기회의"),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("1차 인증"),
                            SizedBox(width: 8),
                            Text(
                                DateFormat('hh시 mm분 ss초 ~ ').format(startTime)),
                            Text(DateFormat('hh시 mm분 ss초').format(endTime)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            curImage,
                            SizedBox(width: 16),
                            Expanded(
                              child: RoundedBorder(
                                height: 48,
                                child: Center(child: Text(tempText)),
                                onTap: () async {
                                  if (DateTime.now().isAfter(startTime) &&
                                      DateTime.now().isBefore(endTime)) {
                                    setState(() {
                                      tempText = "출석중";
                                    });
                                    await initPlatformState();
                                    await BeaconsPlugin.startMonitoring();
                                    await waitForGetResult();
                                    setState(() {
                                      tempText = "출석완료";
                                      curImage =
                                          _getImage(FeeStateType.Done, 64.0);
                                    });
                                    await BeaconsPlugin.stopMonitoring();
                                  } else if (DateTime.now().isAfter(endTime) &&
                                      DateTime.now().isBefore(lateTime)) {
                                    setState(() {
                                      tempText = "출석중";
                                    });
                                    await initPlatformState();
                                    await BeaconsPlugin.startMonitoring();
                                    await waitForGetResult();
                                    setState(() {
                                      tempText = "지각";
                                    });
                                    await BeaconsPlugin.stopMonitoring();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DefaultAlert(
                                        title: "출석체크 실패!",
                                        description: "출석 가능한 시간이 아닙니다.",
                                        messageType: MessageType.OK,
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 28),
                        ListDivider(),
                        SizedBox(height: 24),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("2차 인증"),
                            SizedBox(width: 8),
                            Text("18시 50분 00초 ~  19시 09분 59초"),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/none.png",
                              scale: 0.6,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: RoundedBorder(
                                height: 48,
                                child: Center(child: Text("출석하기")),
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 56),
            Text("지난 출석"),
            SizedBox(height: 8),
            RoundedBorder(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getPreviousAttendance("3월 7일"),
                  _getPreviousAttendance("3월 14일"),
                  _getPreviousAttendance("3월 21일"),
                  _getPreviousAttendance("3월 28일"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getPreviousAttendance(String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text),
        SizedBox(height: 8),
        Image.asset(
          "assets/images/none.png",
          scale: 0.6,
        ),
      ],
    );
  }
}
