import 'package:domain/member/value_objects/member_filter.dart';
import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

class SortSlidingToggleButton extends StatefulWidget {
  final void Function(SortType sortType) onToggle;
  final SortType initializeValue;
  const SortSlidingToggleButton({
    super.key,
    required this.onToggle,
    required this.initializeValue,
  });

  @override
  State<SortSlidingToggleButton> createState() =>
      _SortSlidingToggleButtonState();
}

class _SortSlidingToggleButtonState extends State<SortSlidingToggleButton> {
  late bool isAscending;

  @override
  void initState() {
    super.initState();
    isAscending = widget.initializeValue == SortType.ascend;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: theme.neutral10, width: 2),
      ),
      width: double.infinity,
      height: 50,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: Duration(milliseconds: 200),
            curve: Curves.linearToEaseOut,
            alignment:
                isAscending ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: (MediaQuery.of(context).size.width - 40) / 2.0,
              decoration: BoxDecoration(
                color: theme.primary10,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAscending = true;
                      widget.onToggle(SortType.ascend);
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "오름차순",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isAscending ? FontWeight.w700 : FontWeight.w500,
                        color: isAscending ? theme.primary80 : theme.neutral40,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAscending = false;
                      widget.onToggle(SortType.descend);
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "내림차순",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            !isAscending ? FontWeight.w700 : FontWeight.w500,
                        color: !isAscending ? theme.primary80 : theme.neutral40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
