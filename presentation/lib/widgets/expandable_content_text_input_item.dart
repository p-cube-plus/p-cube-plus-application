import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_text_field.dart';
import 'package:presentation/widgets/rounded_border.dart';

class ExpandableContentTextInputItem extends StatelessWidget {
  const ExpandableContentTextInputItem({
    super.key,
    required this.keyText,
    required this.textController,
    this.textInputType,
  });

  final String keyText;
  final TextInputType? textInputType;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            keyText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.neutral40,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: RoundedBorder(
            radius: 50,
            color: theme.neutral5,
            child: DefaultTextField(
              fontSize: 14,
              maxLength: 50,
              inputController: textController,
              textAlign: TextAlign.end,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              textType: textInputType,
            ),
          ),
        ),
      ],
    );
  }
}
