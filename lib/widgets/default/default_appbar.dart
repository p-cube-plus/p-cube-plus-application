import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    this.centerTitle,
    this.leftTitle,
    this.leftTitleState,
    this.hasPrevious = true,
    this.contentColor,
    this.backgroundColor,
    this.bottomPadding = 24.0,
  });
  final String? centerTitle;
  final String? leftTitle;
  final Widget? leftTitleState;
  final bool hasPrevious;
  final Color? contentColor;
  final Color? backgroundColor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final topPadding = (leftTitleState == null) ? 19.0 : 34.0;
    return Container(
      //color: backgroundColor ?? theme.backgroundColor,
      decoration: BoxDecoration(
          color: backgroundColor ?? theme.backgroundColor,
          border: Border.all(
            width: 0.0,
            color: backgroundColor ?? theme.backgroundColor,
          )),
      padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: statusBarHeight + topPadding,
          bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: centerTitle != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          if (hasPrevious)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20.0,
                color: contentColor ?? theme.textTheme.headline1!.color,
              ),
            )
          else
            SizedBox(),
          if (centerTitle != null)
            Text(
              centerTitle!,
              style: theme.textTheme.headline1!.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: contentColor ?? theme.textTheme.headline1!.color,
              ),
            ),
          if (leftTitle != null)
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 4.0),
              child: Row(
                children: [
                  Text(
                    leftTitle!,
                    style: theme.textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: contentColor ?? theme.textTheme.headline1!.color,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 4), child: leftTitleState)
                ],
              ),
            ),
          SizedBox(width: centerTitle != null ? 20.0 : 0.0)
        ],
      ),
    );
  }
}

// class DefaultAppBar extends StatelessWidget {
//   const DefaultAppBar({
//     Key? key,
//     this.title,
//     this.secondTitle,
//     this.subtitle,
//     this.height,
//     this.actions,
//     this.hasPrevious,
//     this.padding,
//     this.appbarTitleColor,
//     this.previousButtonColor,
//     this.subtitleColor,
//   }) : super(key: key);

//   final EdgeInsetsGeometry? padding;
//   final String? title;
//   final String? secondTitle;
//   final String? subtitle;
//   final double? height;
//   final List<Widget>? actions;
//   final bool? hasPrevious;

//   final Color? appbarTitleColor;
//   final Color? subtitleColor;
//   final Color? previousButtonColor;

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> _widgets = <Widget>[];
//     if (title != null)
//       _widgets.insert(
//         0,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title!,
//                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                         fontSize: 24.0,
//                         fontWeight: FontWeight.w700,
//                         color: appbarTitleColor,
//                       ),
//                 ),
//                 if (secondTitle != null)
//                   Padding(
//                     padding: EdgeInsets.only(top: 4),
//                     child: Text(
//                       secondTitle!,
//                       style:
//                           Theme.of(context).textTheme.headlineSmall!.copyWith(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: appbarTitleColor,
//                               ),
//                     ),
//                   )
//               ],
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: actions ?? [],
//               ),
//             ),
//           ],
//         ),
//       );
//     if (hasPrevious ?? false)
//       _widgets.insert(
//         0,
//         Padding(
//           padding: const EdgeInsets.only(bottom: 24.0),
//           child: Stack(
//             children: [
//               Container(
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 child: Text(
//                   subtitle ?? "",
//                   style: Theme.of(context).textTheme.headline1!.copyWith(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w700,
//                         color: subtitleColor,
//                       ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.arrow_back_ios_new,
//                   size: 20.0,
//                   color: previousButtonColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );

//     return Padding(
//       padding: padding ?? EdgeInsets.only(top: 40.0, bottom: 24.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: MediaQuery.of(context).padding.top),
//         ]..add(
//             Container(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: _widgets,
//               ),
//             ),
//           ),
//       ),
//     );
//   }
// }
