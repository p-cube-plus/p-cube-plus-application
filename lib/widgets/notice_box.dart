import 'package:flutter/material.dart';

Widget makeNoticeBox(String title, String descript, String dates) {
  return Card(
      margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(
              Icons.lock_clock,
              size: 32,
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 0,
              ),
            ),
            subtitle: Text(
              descript,
              style: const TextStyle(
                fontSize: 14,
                height: 1.8,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(dates,
                style: TextStyle(
                  fontSize: 13,
                  height: 0,
                )),
            SizedBox(
              width: 20.0,
            ),
          ])
        ],
      ));
}
