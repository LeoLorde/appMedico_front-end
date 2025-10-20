import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String greeting;
  final String userName;
  final String avatarImage;
  final VoidCallback? onSearchTap;

  const HomeAppBar({
    required this.greeting,
    required this.userName,
    required this.avatarImage,
    this.onSearchTap,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(190);

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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text(greeting, style: GoogleFonts.inter(color: Colors.white, fontSize: 20)),
                  Text(
                    userName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 80),
              CircleAvatar(radius: 25, backgroundImage: AssetImage(avatarImage)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: onSearchTap ?? () {},
                    child: Text(
                      'Procure doutores, especialidade...',
                      style: GoogleFonts.inter(color: Colors.white.withOpacity(0.7), fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
