import 'package:flutter/material.dart';
import '../../widgets/default_page_widget.dart';
import '../../widgets/project/inquiry_tile.dart';
import '../../widgets/rounded_border_widget.dart';
import '../../utilities/contants.dart' as Constants;

class ProjectInquiryPage extends StatelessWidget {
  const ProjectInquiryPage({
    required this.projectName,
    required this.projectType,
    required this.inquiryCount,
    Key? key,
  }) : super(key: key);

  final String projectName;
  final String projectType;
  final int inquiryCount;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        subtitle: "프로젝트에 문의하기",
        appBarTitle: projectName,
        appBarSecondTitle: projectType,
        appBarHasPrevious: true,
        scrollable: false,
        floatingActionButton: _FloatingInquiryButton(),
        appBarActions: [
          GestureDetector(
              child: RoundedBorder(
                radius: 20,
                height: 31,
                color: Color(0xFFDE2B13),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  "상태 지정하기",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              onTap: () {}),
        ],
        content: inquiryCount != 0
            ? Column(
                children: List.generate(
                  inquiryCount,
                  (index) => Padding(
                    padding: EdgeInsets.only(top: (index == 0 ? 0.0 : 8.0)),
                    child: InquiryTile(showChat: true, chatCount: index),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: 110),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("아직 문의사항이 없네요.",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      Text("문의사항을 작성해보세요!",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                      Text("답변이 등록될 경우 알림을 보내드립니다.",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ));
  }
}

class _FloatingInquiryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Container();
          }));
        },
        elevation: 7.68,
        focusElevation: 7.68,
        hoverElevation: 7.68,
        disabledElevation: 7.68,
        highlightElevation: 7.68,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Constants.Icons.GetIcon(Constants.Icons.pencil),
        ),
        backgroundColor: Color(0xFFDE2B13).withOpacity(0.88),
      ),
    );
  }
}
