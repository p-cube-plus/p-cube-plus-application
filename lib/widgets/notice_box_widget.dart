import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/widgets/rounded_border_widget.dart';
import '../models/notification_node.dart';
import 'package:intl/intl.dart';

class NoticeBoxWidget extends StatelessWidget {
  const NoticeBoxWidget(this._box);

  final NotificationNode _box;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: RoundedBorder(
        radius: 10.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _box.name,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(width: 4.0),
                    Container(
                      height: 4.0,
                      width: 4.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFDE2B13)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _box.description,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            Text(
              DateFormat("hh:mm").format(DateTime.parse(_box.date)),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );

    return Container(
      child: Card(
        margin: EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 0),
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: Icon(
                Icons.lock_clock,
                size: 32,
              ),
              trailing: Text(_box.date,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 0,
                  )),
              title: Text(
                _box.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 0,
                ),
              ),
              subtitle: Text(
                _box.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
