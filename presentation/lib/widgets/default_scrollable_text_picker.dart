import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultScrollableTextPicker extends StatefulWidget {
  final List<String> words;
  final int initializeIndex;
  final Color? color;
  final Function(int index) onSelectedItemChanged;

  const DefaultScrollableTextPicker({
    super.key,
    this.color,
    this.initializeIndex = 0,
    required this.words,
    required this.onSelectedItemChanged,
  });

  @override
  State<DefaultScrollableTextPicker> createState() => _ScrollTimePickerState();
}

class _ScrollTimePickerState extends State<DefaultScrollableTextPicker> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initializeIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 32,
      height: 120,
      child: CupertinoPicker(
        selectionOverlay: null,
        backgroundColor: widget.color ?? theme.content,
        itemExtent: 40,
        diameterRatio: 100,
        squeeze: 1,
        onSelectedItemChanged: (index) {
          setState(() => _selectedIndex = index);
          widget.onSelectedItemChanged(index);
        },
        scrollController: FixedExtentScrollController(
          initialItem: widget.initializeIndex,
        ),
        looping: true,
        children: List.generate(widget.words.length, (index) {
          final selected = _selectedIndex == index;
          return Center(
            child: Text(
              widget.words[index],
              style: TextStyle(
                fontSize: 24,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: theme.neutral100,
              ),
            ),
          );
        }),
      ),
    );
  }
}
