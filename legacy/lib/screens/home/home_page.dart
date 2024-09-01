import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/common/extensions/DateTimeExtension.dart';
import 'package:p_cube_plus_application/models/schedule.dart';
import 'package:p_cube_plus_application/providers/api_provider/composite/home_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';
import 'package:p_cube_plus_application/screens/attendence/attendance_history.dart';
import 'package:p_cube_plus_application/screens/attendence/attendance_page.dart';
import 'package:p_cube_plus_application/screens/rent/rent_page.dart';
import 'package:p_cube_plus_application/services/home_api.dart';
import 'package:p_cube_plus_application/widgets/calendar/Home/home_calendar.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:p_cube_plus_application/widgets/common/default_refreshIndicator.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/home/content_summary_view.dart';
import '../../../../presentation/lib/widgets/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../rent/scan_page.dart';
import '../../remote_f/models/rent_dto.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeProvider = HomeProvider(
        context.watch<ScheduleProvider>(), context.watch<RentProvider>());

    return DefaultPage(
      title: "홈",
      content: DefaultRefreshIndicator(
        refreshFunction: homeProvider.refresh,
        child: DefaultFutureBuilder(
          fetchData: homeProvider.fetch(),
          showFunction: (data) => DefaultContent(
            child: Column(
              children: [
                Attendence(),
                HomeCalendar(
                  scheduleProvider: data[#ScheduleProvider],
                ),
                RentListView(rentList: data[#RentProvider].data),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingBarcodeButton(),
    );
  }
}

class Attendence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultFutureBuilder(
      fetchData: HomeAttendanceApi().get(),
      showFunction: (List<Schedule> data) => Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: ContentSummaryView(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceHistoryPage(),
                ),
              );
            },
            title: "출석체크",
            titleFontSize: 16.0,
            children: List.generate(data.length,
                (index) => _getAttendanceContent(context, data, index))),
      ),
    );
  }

  _getAttendanceContent(BuildContext context, List<Schedule> data, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RoundedBorder(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttendancePage(data[index].id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 7.0,
                    width: 7.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: data[index].getMarkColor()),
                  ),
                  SizedBox(width: 12),
                  Column(
                    children: [
                      Text(DateFormat('yyyy.MM.dd')
                          .format(data[index].startDate)),
                      if (data[index].endDate != null &&
                          !data[index]
                              .startDate
                              .isMatchDay(data[index].endDate!))
                        Text(DateFormat('~yyyy.MM.dd')
                            .format(data[index].endDate!)),
                    ],
                  ),
                  SizedBox(width: 8),
                  Text(data[index].title),
                ],
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class RentListView extends StatelessWidget {
  RentListView({
    Key? key,
    required this.rentList,
  }) : super(key: key);

  final List<RentDTO> rentList;

  @override
  Widget build(BuildContext context) {
    return ContentSummaryView(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentPage(),
            ),
          );
        },
        title: "대여한 물품",
        titleFontSize: 16.0,
        children: List.generate(
          rentList.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RoundedBorder(
                hasShadow: true,
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            rentList[index].product.name,
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          SizedBox(height: 2.5),
                          Text(
                            "${DateFormat("yyyy/MM/dd").format(rentList[index].rentDay)} 에 대여함",
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                      Text(
                        rentList[index].dDay == 0
                            ? "D-Day"
                            : "D${rentList[index].dDay.sign == -1 ? "+" : "-"}${rentList[index].dDay}",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: rentList[index].dDay > 7
                                  ? null
                                  : Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class FloatingBarcodeButton extends StatefulWidget {
  @override
  _FloatingBarcodeButton createState() => _FloatingBarcodeButton();
}

class _FloatingBarcodeButton extends State<FloatingBarcodeButton> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("code: $qrcode");
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ScanPage();
          }));
        },
        elevation: 7.68,
        focusElevation: 7.68,
        hoverElevation: 7.68,
        disabledElevation: 7.68,
        highlightElevation: 7.68,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Image.asset(
            "assets/images/scan.png",
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
