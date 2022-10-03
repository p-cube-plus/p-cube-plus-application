import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/providers/schedule_provider.dart';
import 'package:p_cube_plus_application/screens/rent/rent_page.dart';
import 'package:p_cube_plus_application/widgets/content_summary_view.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';
import '../rent/scan_page.dart';
import '../../models/rent.dart';
import '../../providers/rent_provider.dart';
import '../../utilities/contants.dart' as Constants;
import '../../widgets/calendar/calendar.dart';
import '../../widgets/calendar/calendar_summary_view.dart';
import '../../widgets/default_page_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme currentTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RentProvider>(create: (_) => RentProvider()),
        ChangeNotifierProvider<ScheduleProvider>(
          create: (_) => ScheduleProvider(),
        ),
      ],
      child: DefaultPage(
        appBarTitle: "홈",
        content: Column(
          children: [
            HomeCalendar(
              currentTheme: currentTheme,
            ),
            RentListView(),
          ],
        ),
        floatingActionButton: FloatingBarcodeButton(),
      ),
    );
  }
}

class RentListView extends StatelessWidget {
  const RentListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rentProvider = context.watch<RentProvider>();

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
        rentProvider.rentList?.length ?? 0,
        (index) {
          Rent? rent = rentProvider.getRent(index: index);
          if (rent == null) return Container();

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RoundedBorder(
              radius: 10.0,
              //height: 56.0,
              hasShadow: true,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rent.product.name, // debug
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        SizedBox(height: 2.5),
                        Text(
                          "${DateFormat("yyyy/MM/dd").format(rent.date)} 에 대여함", // debug
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      rent.dDay == 0
                          ? "D-Day"
                          : "D${rent.dDay.sign == -1 ? "+" : "-"}${rent.dDay}", // debug
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: rent.dDay > 7 ? null : Color(0xCCDE2B13),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
        backgroundColor: Color(0xFFDE2B13).withOpacity(0.88),
      ),
    );
  }
}

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    Key? key,
    required this.currentTheme,
  }) : super(key: key);

  final TextTheme currentTheme;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _viewDate = DateTime.now();

  List<Color> _dayMarkColor = const [
    Color(0xC9DE2B13),
    Color(0xFF3ABDAD),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarMonthlySummaryView(
          viewDate: _viewDate,
          dayMarkColor: _dayMarkColor,
        ),
        RoundedBorder(
          radius: 10.0,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Calendar(
            headerArrowButtonSize: 40.0,
            headerLeftArrow: SizedBox(
              height: 12.0,
              width: 12.0,
              child: Constants.Icons.GetIcon(
                Constants.Icons.left_arrow,
                color: widget.currentTheme.headline3!.color,
              ),
            ),
            headerRightArrow: SizedBox(
              height: 12.0,
              width: 12.0,
              child: Constants.Icons.GetIcon(
                Constants.Icons.right_arrow,
                color: widget.currentTheme.headline3!.color,
              ),
            ),
            headerMonthTextStyle: widget.currentTheme.headline1!.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            headerYearTextStyle: widget.currentTheme.headline3!.copyWith(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
            ),
            weekDayHeight: 20.0,
            weekDayTextStyle: widget.currentTheme.headline3!.copyWith(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
            ),
            dayHeight: 38.0,
            dayTextStyle: widget.currentTheme.headline1!.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
            ),
            selectedDayTextStyle: widget.currentTheme.headline1!.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            //firstDayOfWeek: 1,
            daySelectedColor: _dayMarkColor[0],
            dayMarkColor: _dayMarkColor,
            onSelectedDateChanged: (date) =>
                setState(() => _selectedDate = date),
            onViewDateChanged: (date) => setState(() {
              _viewDate = date;
            }),
          ),
        ),
        if (_viewDate.month == _selectedDate.month &&
            _viewDate.difference(_selectedDate).inDays.abs() < 32)
          CalendarDailySummaryView(
            dayMarkColor: _dayMarkColor,
            selectedDate: _selectedDate,
          )
        else
          Container(),
      ]..add(SizedBox(height: 20.0)),
    );
  }
}
