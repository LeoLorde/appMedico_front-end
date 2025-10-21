import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderButton extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const GenderButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: selected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.inter(color: selected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
