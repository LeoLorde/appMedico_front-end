import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_med/utils/responsive_helper.dart';

class FormsHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const FormsHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: responsive.fontSize(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.inter(color: Colors.black, fontSize: responsive.fontSize(20)),
        ),
      ],
    );
  }
}
