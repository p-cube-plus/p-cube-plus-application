import 'package:meta/meta.dart';

@immutable
class Color {
  final int hex;
  final int a;
  final int r;
  final int g;
  final int b;

  const Color(this.hex)
      : a = (hex >> 24) & 0xFF,
        r = (hex >> 16) & 0xFF,
        g = (hex >> 8) & 0xFF,
        b = hex & 0xFF;

  @override
  bool operator ==(covariant Color other) {
    if (identical(this, other)) return true;

    return other.hex == hex;
  }

  @override
  int get hashCode {
    return hex.hashCode ^ r.hashCode ^ g.hashCode ^ b.hashCode;
  }
}
