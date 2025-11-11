import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:app_med/utils/responsive_helper.dart';

class FormsTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final VoidCallback? onTap;

  const FormsTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.inputFormatters,
    this.readOnly,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: responsive.fontSize(18),
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: responsive.height(10)),
        TextField(
          controller: controller,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          readOnly: readOnly ?? false,
          onTap: onTap,
          style: GoogleFonts.inter(fontSize: responsive.fontSize(16)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(fontSize: responsive.fontSize(16)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.width(16),
              vertical: responsive.height(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
