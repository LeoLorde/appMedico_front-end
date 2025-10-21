import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const WhiteButton({
    required this.label,
    required this.onPressed,
    this.width = 350,
    this.height = 50,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label, style: GoogleFonts.inter(fontSize: 20, color: Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 1, color: Colors.black),
        ),
      ),
    );
  }
}
