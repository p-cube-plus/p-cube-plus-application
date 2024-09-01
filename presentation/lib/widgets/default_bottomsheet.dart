import 'package:flutter/material.dart';
import 'package:presentation/theme/text_theme_extension.dart';

class DefaultBottomsheet extends StatelessWidget {
  const DefaultBottomsheet(this.content, {super.key});
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              height: 4,
              width: 64,
              color: Theme.of(context).neutral10,
            ),
          ),
          const SizedBox(height: 36),
          content,
        ]);
  }
}

class BottomSheetBuilder {
  build(BuildContext context, Widget content) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => DefaultBottomsheet(content));
  }
}
