import 'package:flutter/material.dart';
import 'package:presentation/extensions/theme_data_extension.dart';

enum MessageType {
  ok,
  okCancel,
}

class DefaultAlert extends StatelessWidget {
  const DefaultAlert({
    super.key,
    this.backgroundColor,
    required this.title,
    required this.messageType,
    this.description,
    this.descriptionColor,
    this.children,
    this.onTapOk,
    this.onTapCancel,
    this.cancelString,
    this.okString,
  });

  final Color? backgroundColor;
  final String title;
  final String? description;
  final String? cancelString;
  final String? okString;
  final Color? descriptionColor;
  final MessageType messageType;
  final List<Widget>? children;
  final void Function()? onTapOk;
  final void Function()? onTapCancel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isCenterTitle = description != null;
    return AlertDialog(
        backgroundColor: backgroundColor ?? theme.background,
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        contentPadding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: isCenterTitle ? 36.0 : 24.0,
            bottom: 16.0),
        content: SizedBox(
          width: 280,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isCenterTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.displayLarge!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (isCenterTitle)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                    child: Text(
                      description!,
                      style: theme.textTheme.displayLarge!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: descriptionColor ??
                            theme.textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                ...children ?? [const SizedBox()],
                messageType == MessageType.ok
                    ? SizedBox(
                        width: double.infinity,
                        height: 35.0,
                        child: ElevatedButton(
                          onPressed: onTapOk ?? () => Navigator.pop(context),
                          child: Text(okString ?? "확인",
                              style: TextStyle(color: Colors.white)),
                        ))
                    : SizedBox(
                        width: double.infinity,
                        height: 35.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                onTap: () {
                                  onTapCancel?.call();
                                  Navigator.pop(context);
                                },
                                highlightColor:
                                    theme.neutral10.withOpacity(0.3),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: theme.neutral10,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      cancelString ?? "취소",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: theme.neutral100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                onTap: () {
                                  onTapCancel?.call();
                                  Navigator.pop(context);
                                },
                                highlightColor:
                                    theme.primary80.withOpacity(0.3),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: theme.primary80,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      okString ?? "확인",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ]),
        ));
  }
}

class DialogBuilder {
  Future build(BuildContext context, DefaultAlert alert) {
    return showDialog(
      context: context,
      builder: (context) => alert,
    );
  }
}
