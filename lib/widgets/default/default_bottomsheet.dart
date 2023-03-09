import 'package:flutter/material.dart';

class DefaultBottomsheet extends StatelessWidget {
  const DefaultBottomsheet({required this.title, this.contents});
  final String title;
  final List<Widget>? contents;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
          child: Text(title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  )),
        ),
      ]
        ..addAll(contents ?? [SizedBox()])
        ..add(const SizedBox(height: 56.0)),
    );
  }
}

/*
showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            builder: (context) => DefaultBottomsheet(
                  title: "",
                  contents: [],
                )),
*/