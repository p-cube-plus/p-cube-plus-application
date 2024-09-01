import 'package:flutter/material.dart';

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
    this.onTap,
  });

  final Color? backgroundColor;
  final String title;
  final String? description;
  final Color? descriptionColor;
  final MessageType messageType;
  final List<Widget>? children;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isCenterTitle = description != null;
    return AlertDialog(
        backgroundColor: backgroundColor ?? theme.colorScheme.surface,
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        contentPadding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: isCenterTitle ? 36.0 : 24.0,
            bottom: 16.0),
        content: SizedBox(
          width: double.infinity,
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
                          onPressed: onTap ?? () => Navigator.pop(context),
                          child: const Text("확인",
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
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Theme.of(context)
                                                    .dialogBackgroundColor)),
                                child: Text("취소",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700)),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed:
                                      onTap ?? () => Navigator.pop(context),
                                  child: const Text("확인",
                                      style: TextStyle(color: Colors.white))),
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
