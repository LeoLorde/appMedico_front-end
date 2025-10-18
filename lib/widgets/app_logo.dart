import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({this.size = 120, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.png', width: size, height: size);
  }
}
