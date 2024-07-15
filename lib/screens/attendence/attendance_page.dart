import 'dart:async';
import 'dart:io' show Platform;
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/common/extensions/DateTimeExtension.dart';
import 'package:p_cube_plus_application/common/extensions/StringExtension.dart';
import 'package:p_cube_plus_application/remote/models/attendance.dart';
import 'package:p_cube_plus_application/remote/models/attendance_dto.dart';
import 'package:p_cube_plus_application/models/enum/state_type.dart';
import 'package:p_cube_plus_application/services/attendance_api.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/list_divider.dart';
import 'package:p_cube_plus_application/widgets/page/default_content.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/utils/theme.dart';
import '../../widgets/common/default_alert.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/page/default_appbar.dart';
import '../../widgets/page/default_page.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage(this.attendanceId);
  final int attendanceId;

  // 출석 체크 기간인지 확인
  final bool shouldCheck = true;

  // 더미 데이터. 마지막 출석날짜를 확인해야함.
  final DateTime lastAttendance = DateTime.now();

  // 더미 데이터. 이전 출석체크 기록을 가져야함.
  final Map<String, StateType> prevStates = {
    DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 21))):
        StateType.negative,
    DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 14))):
        StateType.late,
    DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 7))):
        StateType.positive,
    DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 0))):
        StateType.off,
  };

  // 1, 2차 인증 기간
  final List<DateTime?> startTimes = [
    DateTime(2023, 08, 01, 13),
    DateTime(2023, 08, 01, 13)
  ];
  final List<DateTime?> endTimes = [
    DateTime(2023, 08, 30, 23),
    DateTime(2023, 08, 30, 23)
  ];

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage>
    with WidgetsBindingObserver {
  // 비콘 데이터
  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();
  bool _isInForeground = true;
  String? _beaconResult;

  // 지각은 15분까지 인정된다.
  late List<DateTime> lateTimes = [
    widget.endTimes[0]!.add(Duration(minutes: 15)),
    widget.endTimes[1]!.add(Duration(minutes: 15)),
  ];

  // 현재 상태 관리 => 임시 데이터. 서버와 연동해야 한다.
  DateTime curDate = DateTime.now();
  List<StateType> curStates = [StateType.off, StateType.off];
  List<DateTime?> checkTime = [null, null];

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

  _getImage(StateType type, double size) {
    return Image.asset("assets/images/${type.toString().split('.').last}.png",
        width: size, height: size);
  }

  Future<void> initPlatformState() async {
    await [
      Permission.locationWhenInUse,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth
    ].request().then((statuses) async {
      bool isAllGranted = statuses.values.every((status) => status.isGranted);
      if (!isAllGranted) {
        await showDialog(
            context: context,
            builder: (context) => DefaultAlert(
                  title: "권한 요청",
                  description:
                      "해당 앱은 블루투스를 찾기 위해 위치 정보를 사용합니다.\n위치 권한을 허용해주세요.",
                  messageType: MessageType.OK,
                ));

        await openAppSettings();
        Navigator.pop(context);
      }
    });

    if (Platform.isAndroid) {
      BeaconsPlugin.addRegion("Pcube+", "e2c56db5-dffb-48d2-b060-d0f5a71096e0")
          .then((value) => print("비콘 등록 완료"));
      BeaconsPlugin.addBeaconLayoutForAndroid(
          "m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24");

      BeaconsPlugin.setForegroundScanPeriodForAndroid(
          foregroundScanPeriod: 1100, foregroundBetweenScanPeriod: 100);

      BeaconsPlugin.setBackgroundScanPeriodForAndroid(
          backgroundScanPeriod: 1100, backgroundBetweenScanPeriod: 100);

      //   BeaconsPlugin.channel.setMethodCallHandler((call) async {
      //     print("함수: ${call.method}");
      //     if (call.method == 'scannerReady') {
      //       print("준비됨");
      //     }
      //   });
    } else if (Platform.isIOS) {
      BeaconsPlugin.addRegionForIOS(
          "e2c56db5-dffb-48d2-b060-d0f5a71096e0", 40011, 32023, "Pcube+");
    }

    BeaconsPlugin.setDebugLevel(2);
    BeaconsPlugin.listenToBeacons(beaconEventsController);

    // 스캔 시 지속적으로 불리는 함수
    beaconEventsController.stream.listen(
        (data) async {
          if (data.isNotEmpty && _beaconResult == null) {
            setState(() {
              _beaconResult = data;
            });
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
    while (_beaconResult == null) {
      await Future.delayed(Duration(milliseconds: 1000));
      print("결과 기다리는중..");
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultPage(
      content: DefaultFutureBuilder(
        fetchData: AttendanceCheckApi(widget.attendanceId).get(),
        showFunction: (AttendanceCheckDTO? data) => DefaultPage(
          title: "출석체크",
          appbar: DefaultAppBar(),
          content: DefaultContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "오늘의 출석체크",
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                // 출석체크 기간일 때
                if (widget.shouldCheck)
                  _shouldCheckWidget(theme, data?.attendance)
                // 출석체크 기간이 아닐 때
                else
                  RoundedBorder(
                    height: 270,
                    color: theme.dialogBackgroundColor,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "오늘은 정기회의가 없어요.",
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "출석체크가 제대로 조회되지 않는 경우\n임원진에게 문의해주세요.",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.displaySmall!.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 56),
                Text(
                  "지난 출석",
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                RoundedBorder(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getPreviousAttendance(theme, data?.recordList),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shouldCheckWidget(ThemeData theme, AttendanceDTO? attendance) {
    return RoundedBorder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${curDate.month}월 ${curDate.day}일 정기회의",
            style: theme.textTheme.displayLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _checkWidget(theme, 0),
                SizedBox(height: 28),
                ListDivider(),
                SizedBox(height: 24),
                _checkWidget(theme, 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _checkWidget(ThemeData theme, int type) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${type + 1}차 인증",
                style: theme.textTheme.displaySmall!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              if (widget.startTimes[type] != null)
                Row(
                  children: [
                    Text(
                      DateFormat('hh시 mm분 ss초 ~ ')
                          .format(widget.startTimes[type]!),
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat('hh시 mm분 ss초').format(widget.endTimes[type]!),
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              else
                Text(
                  '아직 ${type + 1}차 인증 시간이 정해지지 않았어요.',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getImage(curStates[type], 64.0),
              SizedBox(width: 16),
              Expanded(
                child: _getAttendanceBox(theme, type),
              )
            ],
          )
        ]);
  }

  RoundedBorder _getAttendanceBox(ThemeData theme, int type) {
    return RoundedBorder(
      height: 48,
      color: curStates[type] == StateType.off && widget.startTimes[type] != null
          ? theme.primaryColor
          : curStates[type] == StateType.positive
              ? MyThemes.secondary20
              : theme.textTheme.displaySmall!.color!.withAlpha(102),
      child: Center(child: _getAttendanceText(theme, type)),
      onTap: () async {
        if (widget.startTimes[type] == null) return;
        if (curStates[type] != StateType.off) return;
        if (DateTime.now().isAfter(widget.startTimes[type]!) &&
            DateTime.now().isBefore(widget.endTimes[type]!)) {
          // 출석중
          setState(() {});
          await initPlatformState();
          await BeaconsPlugin.startMonitoring();
          await waitForGetResult();
          setState(() {
            curStates[type] = StateType.positive;
            checkTime[type] = DateTime.now();
          });
          await BeaconsPlugin.stopMonitoring();
        } else if (DateTime.now().isAfter(widget.endTimes[type]!) &&
            DateTime.now().isBefore(lateTimes[type])) {
          // 출석중
          setState(() {});
          await initPlatformState();
          await BeaconsPlugin.startMonitoring();
          await waitForGetResult();
          setState(() {
            curStates[type] = StateType.late;
            checkTime[type] = DateTime.now();
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
    );
  }

  Widget _getAttendanceText(ThemeData theme, int type) {
    bool isReady = (widget.startTimes[type] != null);
    if (curStates[type] == StateType.off)
      return Text("출석하기",
          style: TextStyle(
            color: isReady ? Colors.white : theme.textTheme.displaySmall!.color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ));
    else if (curStates[type] == StateType.positive)
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("출석 완료",
              style: TextStyle(
                color: MyThemes.secondary100,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              )),
          Text(DateFormat('hh시 mm분 ss초').format(checkTime[type]!),
              style: TextStyle(
                color: MyThemes.secondary100,
                fontSize: 9,
                fontWeight: FontWeight.w400,
              )),
        ],
      );
    else if (curStates[type] == StateType.late)
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("지각",
              style: theme.textTheme.headlineSmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              )),
          Text(DateFormat('hh시 mm분 ss초').format(checkTime[type]!),
              style: theme.textTheme.headlineSmall!.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w400,
              )),
        ],
      );
    else if (curStates[type] == StateType.negative)
      return Text("출석 실패",
          style: theme.textTheme.displaySmall!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ));
    else
      return Text("");
  }

  /// 출석일은 주단위로 체크.
  /// 출석날이 해당 주에 없다면 오늘을 기준으로 몇 주 전인지 보여준다.
  /// 출석날이 있다면 해당 날짜로 보여준다.
  List<Widget> _getPreviousAttendance(
      ThemeData theme, List<AttendanceStateDTO>? data) {
    List<Widget> result = [];
    List<DateTime> validDateList = [
      DateTime.now(),
      DateTime.now().subtract(Duration(days: 7)),
      DateTime.now().subtract(Duration(days: 14)),
      DateTime.now().subtract(Duration(days: 21)),
    ];
    List<StateType> stateTypeList = [
      StateType.none,
      StateType.none,
      StateType.none,
      StateType.none,
    ];
    data ??= [];

    data.forEach((element) {
      int weeksAgo = element.date.getWeeksAgo();
      if (weeksAgo >= 0 && weeksAgo < 4) {
        validDateList[weeksAgo] = element.date;
        stateTypeList[weeksAgo] = element.state.toStateType();
      }
    });

    for (int i = 0; i < 4; ++i) {
      result.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Text(
                DateFormat('M월 d일').format(validDateList[i]),
                style: theme.textTheme.headline3!.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
          _getImage(stateTypeList[i], 64.0),
        ],
      ));
    }
    return result.reversed.toList();
  }
}
