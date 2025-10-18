import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormsFieldLabel extends StatelessWidget {
  final String text;

  const FormsFieldLabel({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
