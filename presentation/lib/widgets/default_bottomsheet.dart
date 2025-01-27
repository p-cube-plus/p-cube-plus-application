import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

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
      ],
    );
  }
}

class BottomSheetBuilder {
  Future<T?> build<T>(BuildContext context, Widget content) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Container(
            color: Theme.of(context).background,
            child: DefaultBottomsheet(content),
          ),
        );
      },
    );
  }
}
