import 'package:meta/meta.dart';

@immutable
class Color {
  final int hex;
  final int r;
  final int g;
  final int b;

  const Color(this.hex)
      : r = (hex >> 16) & 0xFF,
        g = (hex >> 8) & 0xFF,
        b = hex & 0xFF;
}
