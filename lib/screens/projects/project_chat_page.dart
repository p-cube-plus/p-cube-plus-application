import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/default_profile.dart';
import 'package:p_cube_plus_application/widgets/default/rounded_border_widget.dart';
import '../../models/project.dart';
import '../../utilities/contants.dart' as Constants;

class ProjectChatPage extends StatelessWidget {
  const ProjectChatPage({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProjectChatAppBar(title: project.name),
            Expanded(
              child: _ProjectChatView(
                contents: [
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. Non dui condimentum morbi molestie ultrices sem sed.",
                      mine: false),
                  _ChatBubble(
                      text:
                          "Lorem ipsum dolor sit amet consectetur. Commodo iaculis tortor mollis turpis auctor augue. ",
                      mine: true),
                ],
              ), // provider 써서 contents 관리
            ),
            _ProjectChatTextBar(),
          ],
        ),
      ),
    );
  }
}

class _ProjectChatView extends StatelessWidget {
  const _ProjectChatView({
    Key? key,
    required this.contents,
  }) : super(key: key);
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    if (contents.length == 0)
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "아직 문의사항이 없네요.",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              "문의사항을 작성해보세요!\n답변이 등록될 경우 아림을 보내드립니다.",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: contents,
        ),
      ),
    );
  }
}

class _ProjectChatTextBar extends StatefulWidget {
  const _ProjectChatTextBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProjectChatTextBar> createState() => _ProjectChatTextBarState();
}

class _ProjectChatTextBarState extends State<_ProjectChatTextBar> {
  bool _sendable = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 52.0,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset.fromDirection(0, 2.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 24.0,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 5,
                  cursorColor: const Color(0xC9DE2B13),
                  cursorWidth: 1.2,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    fillColor: Theme.of(context)
                        .inputDecorationTheme
                        .fillColor!
                        .withAlpha(128),
                    filled: true,
                    enabledBorder: _DefaultInputBorder(),
                    focusedBorder: _DefaultInputBorder(),
                    border: _DefaultInputBorder(),
                    hintText: "메세지를 입력하세요.",
                    hintStyle: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  onChanged: (value) => setState(() {
                    _sendable = value.trim() != "";
                  }),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!_sendable) return;
                // send chat

                _controller.text = "";
                setState(() => _sendable = false);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Constants.Icons.GetIcon(
                  Constants.Icons.send,
                  color: _sendable
                      ? const Color(0xC9DE2B13)
                      : Theme.of(context).textTheme.headline3!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _DefaultInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide.none,
    );
  }
}

class _ProjectChatAppBar extends StatelessWidget {
  const _ProjectChatAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        alignment: Alignment.bottomLeft,
        color: const Color(0xC9DE2B13),
        height: 104.0,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 20.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16.0),
              Text(
                title, // debug
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 4.0),
              RoundedBorder(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2.0,
                ),
                color: Theme.of(context).secondaryHeaderColor,
                child: Text(
                  "문의 가능", // debug
                  style: TextStyle(
                    color: const Color(0xFF575757),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    Key? key,
    required this.text,
    required this.mine,
  }) : super(key: key);
  final bool mine;
  final String text;

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      _Bubble(context, text, mine),
      SizedBox(width: 8.0),
      Text(
        "22.5.7.(화)",
        style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
            ),
      ),
    ];
    if (mine) content = content.reversed.toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mine) SizedBox(width: 24.0) else DefaultProfile(size: 24.0),
          SizedBox(width: 12.0),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: content,
            ),
          ),
        ],
      ),
    );
  }

  Flexible _Bubble(BuildContext context, String content, bool mine) {
    return Flexible(
      child: RoundedBorder(
        color: mine ? Color(0x99DE2B13) : null,
        padding: EdgeInsets.all(16.0),
        child: Text(
          content,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
                color: mine ? Colors.white : null,
              ),
        ),
      ),
    );
  }
}
