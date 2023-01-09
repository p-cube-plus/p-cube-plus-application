import 'package:flutter/material.dart';

enum MessageType {
  OK,
  OKCancel,
}

class AlertFrame extends StatelessWidget {
  final circular = 10.0;
  final children;
  final messageType;
  final okWidget;
  final okText;
  final cancelText;

  AlertFrame(
      {required List<Widget> this.children,
      required MessageType this.messageType,
      this.okText = "확인",
      this.cancelText = "취소",
      Widget? this.okWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(circular))),
      contentPadding: EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getChildren(context),
        ),
      ),
    );
  }

  List<Widget> _getChildren(context) {
    final result = <Widget>[];
    final buttons = <Widget>[];
    result.addAll(children);

    switch (messageType) {
      case MessageType.OK:
        buttons.add(Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(okText),
            style: Theme.of(context).elevatedButtonTheme.style,
          ),
        ));
        break;
      case MessageType.OKCancel:
        buttons.add(Expanded(
            child: OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelText!,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
          style: Theme.of(context).outlinedButtonTheme.style,
        )));
        buttons.add(const SizedBox(width: 16.0));
        buttons.add(Expanded(
          child: ElevatedButton(
            onPressed: () => _backFunc(context, okWidget),
            child: Text(okText),
            style: Theme.of(context).elevatedButtonTheme.style,
          ),
        ));
        break;
    }

    result.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: buttons,
        ),
      ),
    );

    return result;
  }

  void _backFunc(context, okWidget) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => okWidget,
    );
  }
}
