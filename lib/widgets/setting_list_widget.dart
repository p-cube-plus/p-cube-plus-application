import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        automaticallyImplyLeading: false,
        //leading: IconButton(
        //  icon: const Icon(Icons.arrow_back),
        //  color: Color.fromARGB(255, 0, 0, 0),
        //  tooltip: '뒤로 가기',
        //  onPressed: () {
        //    Navigator.pop(context);
        //  },
        //),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            physics: NeverScrollableScrollPhysics(),
            //addAutomaticKeepAlives: false,
            children: [
              NewPageSetting("알림", Text('a')),
              ThemeSetting("테마"),
              getDivider(),
              VersionSetting(),
              DialogSetting("피드백 보내기"),
              DevSetting("개발진 목록"),
              getDivider(),
              LogoutSetting(),
            ],
          ),
        ),
      ),
    );
  }

  getDivider() => const Divider(
        height: 40,
        indent: 20,
        endIndent: 20,
        thickness: 0.7,
      );
}

class NewPageSetting extends StatelessWidget {
  final _title;
  final _newPage;
  NewPageSetting(this._title, this._newPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => _newPage,
            ),
          );
        },
        child: Container(
          //color: Colors.white70, //배경색
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(_title),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 15),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeSetting extends StatelessWidget {
  final _title;
  ThemeSetting(this._title);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool _value = themeProvider.isLightMode;
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          _value = !_value;
          themeProvider.toggleTgeme(_value);
        },
        child: Container(
          //color: Colors.white70, //배경색
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(_title),
              const Spacer(),
              if (_value) Text("화이트") else Text("블랙"),

              // 스위치
              Transform.scale(
                scale: 0.7,
                // Switch.adaptive
                // CupertinoSwitch
                // Switch
                child: SizedBox(
                  //width: 40,
                  child: CupertinoSwitch(
                    activeColor: Colors.red,
                    //activeTrackColor: Colors.red.withOpacity(0.4),
                    //inactiveThumbColor: Colors.blue,
                    //inactiveTrackColor: Colors.blue.withOpacity(0.4),
                    //splashRadius: 30, // 클릭 시 색 크기
                    value: themeProvider.isLightMode,
                    onChanged: (value) {
                      _value = value;
                      themeProvider.toggleTgeme(value);
                    },
                  ),
                ),
              ),

              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class VersionSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<PackageInfo>(
        future: _getPackageInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Text('ERROR');
          } else if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          final data = snapshot.data!;

          return Container(
            height: 50,
            child: Container(
              //color: Colors.white70, //배경색
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  const Text('버전'),
                  const Spacer(),
                  Text(data.version),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<PackageInfo> _getPackageInfo() {
  return PackageInfo.fromPlatform();
}

class LogoutSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {},
        child: Container(
          //color: Colors.white70, //배경색
          child: Row(
            children: [
              const SizedBox(width: 20),
              const Text('로그아웃'),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogSetting extends StatelessWidget {
  final _title;
  DialogSetting(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) => writeFeedback(ctx));
        },
        child: Container(
          //color: Colors.white70, //배경색
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(_title),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 15),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  writeFeedback(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      content: Builder(builder: (context) {
        //final height = MediaQuery.of(context).size.height;
        //final width = MediaQuery.of(context).size.width;
        return Container(
          height: 355,
          width: 348,
          child: Column(
            children: [
              Align(
                child: const Text('피드백 보내기'),
                alignment: Alignment.topLeft,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    labelText: '이름을 입력하세요',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white10),
                scrollPadding: EdgeInsets.all(20.0),
              ),
              SizedBox(height: 15),
              TextField(
                maxLines: 10,
                maxLength: 200,
                decoration: InputDecoration(
                    labelText: '내용을 입력하세요', border: OutlineInputBorder()),
                scrollPadding: EdgeInsets.all(20.0),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        );
      }),
      actions: [
        Row(
          children: [
            SizedBox(width: 16),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('취소'),
              style: OutlinedButton.styleFrom(minimumSize: Size(174, 50)),
            ),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) => checkFeedback(ctx),
                );
              },
              child: Text('보내기'),
              style: ElevatedButton.styleFrom(minimumSize: Size(174, 50)),
            ),
          ],
        ),
      ],
    );
  }

  checkFeedback(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      content: Builder(builder: (context) {
        //final height = MediaQuery.of(context).size.height;
        //final width = MediaQuery.of(context).size.width;
        return Container(
          height: 80,
          width: 348,
          child: Column(
            children: [
              Align(
                child: const Text('피드백이 제출되었습니다!'),
                alignment: Alignment.center,
              ),
              SizedBox(height: 17),
              Align(
                child: const Text(
                  '소중한 의견 감사합니다.',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(height: 15),
            ],
          ),
        );
      }),
      actions: [
        Row(
          children: [
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
              style: OutlinedButton.styleFrom(minimumSize: Size(363, 50)),
            ),
          ],
        ),
      ],
    );
  }
}

class DevSetting extends StatelessWidget {
  final _title;
  DevSetting(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context, builder: (BuildContext ctx) => showDev(ctx));
        },
        child: Container(
          //color: Colors.white70, //배경색
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(_title),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 15),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  showDev(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      content: Builder(builder: (context) {
        //final height = MediaQuery.of(context).size.height;
        //final width = MediaQuery.of(context).size.width;
        return Container(
          height: 190,
          width: 348,
          child: Column(
            children: [
              Align(
                child: const Text('개발진'),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 3),
              Align(
                child: const Text(
                  'PCube+의 개발진 목록입니다.',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 15),
              Align(child: const Text('오창한'), alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Align(child: const Text('권오민'), alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Align(child: const Text('조승빈'), alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Align(child: const Text('신혜민'), alignment: Alignment.centerLeft),
            ],
          ),
        );
      }),
      actions: [
        Row(
          children: [
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('닫기'),
              style: OutlinedButton.styleFrom(minimumSize: Size(363, 50)),
            ),
          ],
        ),
      ],
    );
  }
}
