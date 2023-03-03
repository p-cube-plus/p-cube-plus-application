import 'package:flutter/material.dart';

class DefaultBottomsheet {
  static getBottomsheet(context, title, List<Widget> contents) {
    var theme = Theme.of(context);
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 32.0),
                  child: Text(title,
                      style: theme.textTheme.headline1!.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ]
                ..addAll(contents)
                ..add(SizedBox(height: 56.0)),
            ));
  }
}
