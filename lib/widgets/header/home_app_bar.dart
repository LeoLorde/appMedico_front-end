import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/responsive_helper.dart';

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
    final responsive = ResponsiveHelper(context);

    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(
        responsive.width(16),
        responsive.height(40),
        responsive.width(16),
        responsive.height(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: responsive.width(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: responsive.height(25)),
                    Text(
                      greeting,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: responsive.fontSize(20),
                      ),
                    ),
                    Text(
                      userName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: responsive.fontSize(20),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: responsive.width(12)),
              CircleAvatar(radius: responsive.width(25), backgroundImage: AssetImage(avatarImage)),
            ],
          ),
          SizedBox(height: responsive.height(20)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.width(16),
              vertical: responsive.height(12),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(responsive.width(20)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white, size: responsive.fontSize(20)),
                SizedBox(width: responsive.width(10)),
                Expanded(
                  child: GestureDetector(
                    onTap: onSearchTap ?? () {},
                    child: Text(
                      'Procure doutores, especialidade...',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: responsive.fontSize(16),
                      ),
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
