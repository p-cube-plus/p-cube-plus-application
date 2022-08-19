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

  AlertFrame(
      {required List<Widget> this.children,
      required MessageType this.messageType,
      Widget? this.okWidget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(circular))),
      contentPadding: EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _getChildren(context),
          ),
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
            child: Text('확인'),
            style: Theme.of(context).elevatedButtonTheme.style,
          ),
        ));
        break;
      case MessageType.OKCancel:
        buttons.add(Expanded(
            child: OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('취소'),
          style: Theme.of(context).outlinedButtonTheme.style,
        )));
        buttons.add(const SizedBox(width: 16.0));
        buttons.add(Expanded(
          child: ElevatedButton(
            onPressed: () => _backFunc(context, okWidget),
            child: Text('확인'),
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
