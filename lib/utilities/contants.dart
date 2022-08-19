import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Icons {
  static String home = "assets/images/icons/home.svg";
  static String bell = "assets/images/icons/bell.svg";
  static String user = "assets/images/icons/user.svg";

  static String selected_home = "assets/images/icons/home_selected.svg";
  static String selected_bell = "assets/images/icons/bell_selected.svg";
  static String selected_user = "assets/images/icons/user_selected.svg";

  static String left_arrow = "assets/images/icons/arrow_left.svg";
  static String right_arrow = "assets/images/icons/arrow_right.svg";

  static String profile = "assets/images/icons/profile.svg";

  static Widget GetIcon(String icon, {Color? color}) =>
      SvgPicture.asset(icon, color: color);
}
