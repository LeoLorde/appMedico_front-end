import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const UserTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 300,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.black),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(subtitle, style: GoogleFonts.inter(color: Colors.black)),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
