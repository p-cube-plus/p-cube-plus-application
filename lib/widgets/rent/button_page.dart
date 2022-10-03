import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({
    Key? key,
    required this.names,
    required this.contents,
  }) : super(key: key);

  final List<String> names;
  final List<Widget> contents;

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _rowChildren = <Widget>[];

    for (var i = 0; i < widget.names.length; ++i) {
      if (i != _index)
        _rowChildren.add(Padding(
          child: _getInactiveButton(i, widget.names[i]),
          padding: EdgeInsets.only(right: 8),
        ));
      else
        _rowChildren.add(Padding(
          child: _getActiveButton(i, widget.names[i]),
          padding: EdgeInsets.only(right: 8),
        ));
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              child: Row(children: _rowChildren),
              padding: EdgeInsets.only(bottom: 24)),
          SizedBox(
            child: widget.contents[_index],
            height: MediaQuery.of(context).size.height - 266,
          )
        ],
      ),
    );
  }

  Widget _getInactiveButton(index, name) {
    var theme = Theme.of(context);
    return OutlinedButton(
        onPressed: () => setState(() {
              _index = index;
            }),
        child: Text(
          name,
          style: theme.textTheme.headline1!
              .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          side: theme.outlinedButtonTheme.style!.side,
          backgroundColor: MaterialStateProperty.all(theme.cardColor),
          shape: theme.outlinedButtonTheme.style!.shape,
          minimumSize: theme.outlinedButtonTheme.style!.minimumSize,
        ));
  }

  Widget _getActiveButton(index, name) {
    return ElevatedButton(
        onPressed: () => setState(() {
              _index = index;
            }),
        child: Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        style: Theme.of(context).elevatedButtonTheme.style);
  }
}
