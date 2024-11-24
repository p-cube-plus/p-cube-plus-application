import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/widgets/default_scrollable_text_picker.dart';
import 'package:presentation/widgets/rounded_border.dart';

class AttendanceTimePicker extends StatefulWidget {
  final int sequenceNumber;
  final DateTime initializeTime;
  final Function(DateTime selectedTime) onSaveTime;

  const AttendanceTimePicker({
    super.key,
    required this.sequenceNumber,
    required this.initializeTime,
    required this.onSaveTime,
  });

  @override
  State<AttendanceTimePicker> createState() => _AttendanceTimePickerState();
}

class _AttendanceTimePickerState extends State<AttendanceTimePicker> {
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = widget.initializeTime;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "${widget.sequenceNumber}차 인증 시간",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: theme.neutral100,
            ),
          ),
        ),
        RoundedBorder(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultScrollableTextPicker(
                words: List.generate(24, (index) => "$index".padLeft(2, "0")),
                onSelectedItemChanged: (int index) =>
                    time = time.copyWith(hour: index),
                initializeIndex: widget.initializeTime.hour,
              ),
              Text(
                "시",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral80,
                ),
              ),
              DefaultScrollableTextPicker(
                words: List.generate(60, (index) => "$index".padLeft(2, "0")),
                onSelectedItemChanged: (int index) =>
                    time = time.copyWith(minute: index),
                initializeIndex: widget.initializeTime.minute,
              ),
              Text(
                "분",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral80,
                ),
              ),
              DefaultScrollableTextPicker(
                words: List.generate(60, (index) => "$index".padLeft(2, "0")),
                onSelectedItemChanged: (int index) =>
                    time = time.copyWith(second: index),
                initializeIndex: widget.initializeTime.second,
              ),
              Text(
                "초",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.neutral80,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              widget.onSaveTime(time);
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "확인",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
