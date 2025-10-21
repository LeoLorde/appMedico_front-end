import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double fontSize;

  const LinkText({required this.text, required this.onTap, this.fontSize = 18, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: Colors.black,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
