import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackTap;

  const AuthAppBar({required this.title, required this.onBackTap, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBackTap,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
