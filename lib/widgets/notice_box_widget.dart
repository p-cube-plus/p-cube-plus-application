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
        onTap: () {},
        hasShadow: true,
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
  }
}
