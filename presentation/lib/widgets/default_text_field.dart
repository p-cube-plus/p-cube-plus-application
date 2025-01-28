import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' show pi;

import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    super.key,
    this.minLine,
    this.maxLine,
    required this.maxLength,
    this.hintText,
    this.fontSize = 10.0,
    this.contentPadding = 8.0,
    this.textType,
    required this.inputController,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.autofocus = false,
    this.readOnly = false,
    this.focusNode,
    this.showCursor,
    this.enableInteractiveSelection,
    this.enabled = true,
    this.onSubmitted,
    this.onChanged,
  });

  final int? minLine;
  final int? maxLine;
  final int maxLength;
  final String? hintText;
  final double fontSize;
  final double contentPadding;
  final TextInputType? textType;
  final TextAlign textAlign;
  final TextEditingController inputController;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final bool? enableInteractiveSelection;
  final FocusNode? focusNode;
  final bool enabled;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      focusNode: focusNode,
      minLines: minLine ?? 1,
      maxLines: maxLine ?? minLine ?? 1,
      maxLength: maxLength,
      keyboardType: textType,
      cursorColor: theme.neutral100,
      textAlign: textAlign,
      style: TextStyle(
        color: theme.neutral100,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        helperMaxLines: 0,
        errorMaxLines: 0,
        contentPadding: EdgeInsets.all(contentPadding),
        counterText: "",
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.neutral40,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
        ),
      ),
      onSubmitted: onSubmitted,
      controller: inputController,
      onChanged: onChanged,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      selectionControls: CustomTextSelectionControls(),
      enabled: enabled,
      readOnly: readOnly,
      showCursor: showCursor,
      enableInteractiveSelection: enableInteractiveSelection,
    );
  }
}

class CustomTextSelectionControls extends TextSelectionControls {
  final double _kHandleSize = 22;
  late bool isCollapsed;

  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    switch (type) {
      case TextSelectionHandleType.left:
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onTap,
          child: Container(
            width: _kHandleSize,
            height: _kHandleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).textSelectionTheme.selectionHandleColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                bottomLeft: Radius.circular(11.0),
                bottomRight: Radius.circular(11.0),
              ),
            ),
          ),
        );
      case TextSelectionHandleType.right:
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onTap,
          child: Container(
            width: _kHandleSize,
            height: _kHandleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).textSelectionTheme.selectionHandleColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(11.0),
                bottomLeft: Radius.circular(11.0),
                bottomRight: Radius.circular(11.0),
              ),
            ),
          ),
        );
      case TextSelectionHandleType.collapsed:
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onTap,
          child: Transform.rotate(
            angle: 45 * pi / 180,
            child: Container(
              width: _kHandleSize,
              height: _kHandleSize,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textSelectionTheme.selectionHandleColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(11.0),
                  bottomLeft: Radius.circular(11.0),
                  bottomRight: Radius.circular(11.0),
                ),
              ),
            ),
          ),
        );
    }
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    switch (type) {
      case TextSelectionHandleType.left:
        return Offset(_kHandleSize, 0);
      case TextSelectionHandleType.right:
        isCollapsed = false;
        return Offset.zero;
      case TextSelectionHandleType.collapsed:
        isCollapsed = true;
        return Offset(_kHandleSize / 2, -4);
    }
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size.square(_kHandleSize);
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ValueListenable<ClipboardStatus>? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    final List<Widget> items = <Widget>[];
    final theme = Theme.of(context);
    final TextStyle style = Theme.of(context).textTheme.displayLarge!.copyWith(
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
        );

    if (delegate.cutEnabled && !isCollapsed) {
      items.add(TextButton(
        onPressed: () => delegate.cutSelection(SelectionChangedCause.toolbar),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('잘라내기', style: style),
        ),
      ));
    }
    if (delegate.copyEnabled && !isCollapsed) {
      items.add(TextButton(
        onPressed: () => delegate.copySelection(SelectionChangedCause.toolbar),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('복사', style: style),
        ),
      ));
    }
    if (delegate.pasteEnabled) {
      items.add(TextButton(
        onPressed: () => delegate.pasteText(SelectionChangedCause.toolbar),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('붙여넣기', style: style),
        ),
      ));
    }

    if (delegate.selectAllEnabled) {
      items.add(TextButton(
        onPressed: () => delegate.selectAll(SelectionChangedCause.toolbar),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('전체선택', style: style),
        ),
      ));
    }

    return TextSelectionToolbar(
      toolbarBuilder: (context, widget) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: const Color(0x11000000),
                blurRadius: 4.0,
                spreadRadius: 0.0,
                offset: Offset.fromDirection(1, 7),
              )
            ],
            border: Border.all(
              color: theme.neutral10,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: widget),
      anchorAbove: Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top + endpoints[0].point.dy - textLineHeight - 8,
      ),
      anchorBelow: Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            (endpoints.length > 1 ? endpoints[1] : endpoints[0]).point.dy +
            _kHandleSize,
      ),
      children: items,
    );
  }
}
