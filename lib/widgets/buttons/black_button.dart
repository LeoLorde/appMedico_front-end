import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_med/utils/responsive_helper.dart';

class BlackButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  const BlackButton({
    required this.label,
    required this.onPressed,
    this.width = 350,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.inter(fontSize: responsive.fontSize(20), color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(responsive.width(width), responsive.height(height)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
