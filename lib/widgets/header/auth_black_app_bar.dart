import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBlackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String avatarImage;

  const AuthBlackAppBar({
    required this.title,
    required this.subtitle,
    required this.avatarImage,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subtitle, style: GoogleFonts.inter(color: Colors.white, fontSize: 18)),
                ],
              ),
              const Spacer(), // faz o espaço se adaptar automaticamente
              CircleAvatar(radius: 25, backgroundImage: AssetImage(avatarImage)),
            ],
          ),
        ],
      ),
    );
  }
}
