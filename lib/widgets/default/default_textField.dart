import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {this.minLine,
      this.maxLine,
      required this.maxLength,
      this.hintText,
      this.textType,
      required this.inputController});

  final int? minLine;
  final int? maxLine;
  final int maxLength;
  final String? hintText;
  final TextInputType? textType;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      minLines: minLine ?? 1,
      maxLines: maxLine ?? minLine ?? 1,
      maxLength: maxLength,
      keyboardType: textType,
      cursorColor: theme.textTheme.headline1!.color,
      style: theme.textTheme.headline1!
          .copyWith(fontSize: 10.0, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          helperMaxLines: 0,
          errorMaxLines: 0,
          contentPadding: EdgeInsets.all(8.0),
          counterText: "", // 글자수 제한 보이기 삭제
          hintText: hintText,
          hintStyle: theme.textTheme.headline3!.copyWith(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.0, style: BorderStyle.none))),
      toolbarOptions: ToolbarOptions(),
      controller: inputController,
    );
  }
}
