import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_med/utils/responsive_helper.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final DateTime date;
  final String time;
  final String address;
  final String avatarUrl;

  const AppointmentCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.address,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Container(
      margin: EdgeInsets.only(bottom: responsive.height(15)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, 3))],
      ),
      padding: EdgeInsets.all(responsive.width(12)),
      child: Row(
        children: [
          CircleAvatar(radius: responsive.width(28), backgroundImage: AssetImage(avatarUrl)),
          SizedBox(width: responsive.width(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: GoogleFonts.inter(
                    fontSize: responsive.fontSize(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  specialty,
                  style: GoogleFonts.inter(
                    fontSize: responsive.fontSize(13),
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: responsive.height(5)),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: responsive.fontSize(16),
                      color: Colors.black87,
                    ),
                    SizedBox(width: responsive.width(5)),
                    Text(
                      '${date.day}/${date.month}',
                      style: GoogleFonts.inter(fontSize: responsive.fontSize(13)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: responsive.fontSize(16), color: Colors.black87),
                    SizedBox(width: responsive.width(5)),
                    Text(time, style: GoogleFonts.inter(fontSize: responsive.fontSize(13))),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: responsive.fontSize(16),
                      color: Colors.black87,
                    ),
                    SizedBox(width: responsive.width(5)),
                    Expanded(
                      child: Text(
                        address,
                        style: GoogleFonts.inter(fontSize: responsive.fontSize(13)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
