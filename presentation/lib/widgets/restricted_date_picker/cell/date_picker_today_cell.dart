import 'package:flutter/material.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/restricted_date_picker/restricted_date_picker_view_model.dart';

class RestrictedDatePickerTodayCell extends StatelessWidget
    with ViewModel<RestrictedDatePickerViewModel> {
  final int currentDay;
  final bool isClickable;

  const RestrictedDatePickerTodayCell(
    this.currentDay,
    this.isClickable, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap(context),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              width: 28.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primary10,
              ),
            ),
          ),
          Text(
            "$currentDay",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: theme.primary60,
            ),
          ),
          Positioned(
            bottom: -5,
            child: Text(
              "오늘",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: theme.primary60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Function()? onTap(BuildContext context) {
    if (!isClickable) return null;
    return () => read(context).changeSelectedDay(currentDay);
  }
}
