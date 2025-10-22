import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqCard extends StatelessWidget {
  final String question;
  final String answer;

  const FaqCard({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            question,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          children: [Text(answer, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]))],
        ),
      ),
    );
  }
}
