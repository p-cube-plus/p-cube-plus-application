import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/providers/api_provider/composite/home_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';
import 'package:p_cube_plus_application/screens/attendence/attendance_page.dart';
import 'package:p_cube_plus_application/screens/rent/rent_page.dart';
import 'package:p_cube_plus_application/widgets/common/default_futureBuilder.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';
import '../../widgets/common/rounded_border.dart';
import '../../widgets/home/content_summary_view.dart';
import '../../widgets/page/default_content.dart';
import '../../widgets/page/default_page.dart';
import '../rent/scan_page.dart';
import '../../models/rent.dart';
import '../../widgets/calendar/calendar.dart';
import '../../widgets/calendar/Home/calendar_summary_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme currentTheme = Theme.of(context).textTheme;
    var homeProvider = HomeProvider(
        context.watch<ScheduleProvider>(), context.watch<RentProvider>());

    return DefaultPage(
      title: "홈",
      content: DefaultFutureBuilder(
        fetchData: homeProvider.fetch(),
        refreshData: homeProvider.refresh(),
        showFunction: (data) => DefaultContent(
          child: Column(
            children: [
              Attendence(),
              HomeCalendar(
                currentTheme: currentTheme,
                scheduleProvider: data[#ScheduleProvider],
              ),
              RentListView(rentList: data[#RentProvider].data),
            ],
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: ContentSummaryView(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendancePage(),
              ),
            );
          },
          title: "출석체크",
          titleFontSize: 16.0,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RoundedBorder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 18.0),
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
                                color: Color(0xFFE55542)),
                          ),
                          SizedBox(width: 12),
                          Text("2022.08.17"),
                          SizedBox(width: 8),
                          Text("판도라큐브 정기회의"),
                        ],
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    Key? key,
    required this.currentTheme,
    required this.scheduleProvider,
  }) : super(key: key);

  final TextTheme currentTheme;
  final ScheduleProvider scheduleProvider;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate = DateTime.now();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarUpComingSummaryView(
          scheduleList: widget.scheduleProvider.getUpcomingSchedule(),
        ),
        RoundedBorder(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Calendar(
            onSelectedDateChanged: (date) =>
                setState(() => _selectedDate = date),
            isHomeCalendar: true,
            scheduleProvider: widget.scheduleProvider,
          ),
        ),
        CalendarSelectedDateSummaryView(
          selectedDate: _selectedDate,
          selectedSchedule:
              widget.scheduleProvider.getTodaySchedule(_selectedDate),
        )
      ]..add(SizedBox(height: 20.0)),
    );
  }
}

class RentListView extends StatelessWidget {
  RentListView({
    Key? key,
    required this.rentList,
  }) : super(key: key);

  final List<Rent> rentList;

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
