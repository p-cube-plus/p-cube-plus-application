import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import '../../widgets/default_page_widget.dart';
import 'fee_detail_page.dart';

enum FeeStateType { None, Done, Late, Due, Wait }

_getImage(type, size) {
  if (type == FeeStateType.Done)
    return Image.asset("assets/images/positive.png", width: size, height: size);
  else if (type == FeeStateType.Late)
    return Image.asset("assets/images/late.png", width: size, height: size);
  else if (type == FeeStateType.Due)
    return Image.asset("assets/images/negative.png", width: size, height: size);
  else if (type == FeeStateType.Wait)
    return Image.asset("assets/images/off.png", width: size, height: size);
  else
    return Image.asset("assets/images/none.png", width: size, height: size);
}

class FeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      appBarTitle: "회비",
      appBarHasPrevious: false,
      scrollable: false,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: MonthFee(
                  type: FeeStateType.Done,
                  startDay: DateTime(2022, 10, 6),
                  endDay: DateTime(2022, 10, 13),
                  charge: 5000,
                )),
            Padding(padding: EdgeInsets.only(bottom: 40), child: AnnualFee()),
            FeeInfo(sum: 1200340),
          ],
        ),
      ),
    );
  }
}

class MonthFee extends StatelessWidget {
  const MonthFee({required this.type, this.startDay, this.endDay, this.charge});
  final FeeStateType type;
  final DateTime? startDay;
  final DateTime? endDay;
  final int? charge;

  _getText() {
    if (type == FeeStateType.Done)
      return "회부 납부 완료!";
    else if (type == FeeStateType.Late)
      return "회비 납부 완료!\n납부 기간을 꼭 지켜주세요.";
    else if (type == FeeStateType.Due)
      return "아직 회비를 납부하지 않았어요.";
    else if (type == FeeStateType.Wait) return "회비 납부 기간이 아닙니다.";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text("이번 달 회비 납부",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        RoundedBorder(
          width: double.infinity,
          onTap: () {},
          color: Theme.of(context).scaffoldBackgroundColor,
          radius: 10,
          child: Padding(
            padding: EdgeInsets.only(top: 32, bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                Container(
                    height: 72,
                    width: 72,
                    margin: EdgeInsets.only(bottom: 16),
                    child: _getImage(type, 72.0)),
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Text(_getText(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                if (type != FeeStateType.Wait)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("납부 기간"),
                        Text(DateFormat('MM월 dd일 ~').format(startDay!) +
                            DateFormat('MM월 dd일').format(endDay!))
                      ],
                    ),
                  ),
                if (type != FeeStateType.Wait)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("납부 금액"),
                      Text(NumberFormat('###,###,###원').format(charge!))
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnnualFee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text("연도별 회비 납부",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        YearCalender(),
      ],
    );
  }
}

class YearCalender extends StatefulWidget {
  @override
  State<YearCalender> createState() => _YearCalenderState();
}

class _YearCalenderState extends State<YearCalender> {
  int _curYear = DateTime.now().year;

  _getCurYearInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getYearData(1, FeeStateType.None),
            _getYearData(2, FeeStateType.None),
            _getYearData(3, FeeStateType.Late),
            _getYearData(4, FeeStateType.Done),
            _getYearData(5, FeeStateType.Done),
            _getYearData(6, FeeStateType.Done),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getYearData(7, FeeStateType.Late),
            _getYearData(8, FeeStateType.Done),
            _getYearData(9, FeeStateType.Due),
            _getYearData(10, FeeStateType.None),
            _getYearData(11, FeeStateType.None),
            _getYearData(12, FeeStateType.None),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: ((details) {
        setState(() {
          details.velocity.pixelsPerSecond.dx > 0.0
              ? ++_curYear
              : details.velocity.pixelsPerSecond.dx < 0.0
                  ? --_curYear
                  : _curYear = _curYear;
        });
      }),
      child: RoundedBorder(
          color: Theme.of(context).scaffoldBackgroundColor,
          radius: 10,
          child: Padding(
            padding: EdgeInsets.only(bottom: 32, top: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => --_curYear),
                              child: Icon(Icons.chevron_left))),
                      Text(
                        _curYear.toString() + "년",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 22.5),
                          child: GestureDetector(
                              onTap: () => setState(() => ++_curYear),
                              child: Icon(Icons.chevron_right))),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _getCurYearInfo(),
                ),
              ],
            ),
          )),
    );
  }

  _getYearData(int month, FeeStateType type) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            month.toString() + "월",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
        _getImage(type, 32.0)
      ],
    );
  }
}

class FeeInfo extends StatelessWidget {
  const FeeInfo({required this.sum});
  final int sum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text("회비 내역",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
        RoundedBorder(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeeDetailPage(),
            ),
          ),
          radius: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(NumberFormat('###,###,###원').format(sum),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    Text("자세히 보기",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    Icon(Icons.chevron_right)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
