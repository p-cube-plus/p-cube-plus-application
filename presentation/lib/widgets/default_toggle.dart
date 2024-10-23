import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class DefaultToggle extends StatefulWidget {
  final bool value;
  final Function(bool isOn)? onChanged;

  final double width;
  final double height;
  final double radius;
  final Duration animationDuration;

  const DefaultToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.width = 32,
    this.height = 16,
    this.radius = 50,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<DefaultToggle> createState() => _DefaultToggleState();
}

class _DefaultToggleState extends State<DefaultToggle> {
  late bool isOn;
  late Color targetColor;

  @override
  void initState() {
    super.initState();
    isOn = widget.value;
  }

  @override
  void didUpdateWidget(covariant DefaultToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    isOn = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color backgroundColor = theme.primary80;
    final Color offColor = theme.neutral60;
    targetColor = isOn ? backgroundColor : offColor;

    final togglePadding = 2.0;

    return GestureDetector(
      onTap: () => _onTapToggle(backgroundColor, offColor),
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(
          begin: isOn ? backgroundColor : offColor,
          end: targetColor,
        ),
        duration: widget.animationDuration,
        curve: Curves.easeInOutSine,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              duration: widget.animationDuration,
              curve: Curves.easeInOutSine,
              child: Padding(
                padding: EdgeInsets.all(togglePadding),
                child: Container(
                  width: widget.height - togglePadding,
                  height: widget.height - togglePadding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        builder: (context, color, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _onTapToggle(Color backgroundColor, Color offColor) {
    setState(() {
      isOn = !isOn;
      targetColor = isOn ? backgroundColor : offColor;
    });
    widget.onChanged?.call(isOn);
  }
}
