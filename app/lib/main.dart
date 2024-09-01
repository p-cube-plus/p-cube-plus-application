import 'package:flutter/material.dart';
import 'package:presentation/p_cube_plus_app.dart';
import 'init_service.dart' as ioc;

void main() async {
  ioc.initService();
  runApp(PCubePlusApp());
}
