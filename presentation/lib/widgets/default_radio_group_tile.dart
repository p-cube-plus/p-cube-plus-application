import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class RadioData<T> {
  final String title;
  final T data;
  RadioData({
    required this.title,
    required this.data,
  });
}

class DefaultRadioGroupTile<T> extends StatefulWidget {
  const DefaultRadioGroupTile({
    super.key,
    required this.onTap,
    required this.radioDataList,
    required this.initializeIndex,
  });

  final Function(T) onTap;
  final List<RadioData<T>> radioDataList;
  final int initializeIndex;

  @override
  State<DefaultRadioGroupTile<T>> createState() =>
      _DefaultRadioGroupTileState<T>();
}

class _DefaultRadioGroupTileState<T> extends State<DefaultRadioGroupTile<T>> {
  late int selectedIndex;
  var _refreshKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initializeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.radioDataList.length, (index) {
        return GestureDetector(
          onTap: () {
            widget.onTap(widget.radioDataList[index].data);
            setState(() {
              selectedIndex = index;
              _refreshKey = UniqueKey();
            });
          },
          child: RadioButton(
            key: _refreshKey,
            title: widget.radioDataList[index].title,
            isActive: index == selectedIndex,
          ),
        );
      }),
    );
  }
}

class RadioButton extends StatelessWidget {
  final String title;
  final bool isActive;

  const RadioButton({
    super.key,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final innerColor = isActive ? theme.primary80 : Colors.transparent;
    final innerRadius = isActive ? 3.5 : 0.0;
    final outterColor = isActive ? theme.primary80 : theme.neutral40;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          CustomPaint(
            size: Size(20, 20),
            painter: RadioButtonPainter(
              innerColor: innerColor,
              outterColor: outterColor,
              innerRadius: innerRadius,
              outterRadius: 8,
              outterStroke: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class RadioButtonPainter extends CustomPainter {
  final Color innerColor;
  final double innerRadius;
  final Color outterColor;
  final double outterRadius;
  final double outterStroke;
  RadioButtonPainter({
    required this.innerColor,
    required this.innerRadius,
    required this.outterColor,
    required this.outterRadius,
    required this.outterStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), innerRadius, paint);

    final outerPaint = Paint()
      ..color = outterColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = outterStroke;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), outterRadius, outerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
