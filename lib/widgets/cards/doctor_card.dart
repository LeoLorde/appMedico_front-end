import 'package:app_med/screens/client/search_doctor/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final String imageUrl;
  final String hour;
  final String day;

  const DoctorCard({
    Key? key,
    required this.doctor,
    required this.imageUrl,
    required this.hour,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(radius: 35, backgroundImage: NetworkImage(imageUrl)),
            const SizedBox(width: 25),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${doctor.username}',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    doctor.especialidade ?? '',
                    style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, color: Colors.grey, size: 16),
                      SizedBox(width: 4),
                      Text('$day', style: GoogleFonts.inter(fontSize: 16)),
                      SizedBox(width: 20),
                      Text('|'),
                      SizedBox(width: 20),
                      Icon(Icons.watch_later_outlined, color: Colors.grey, size: 16),
                      SizedBox(width: 4),
                      Text('$hour', style: GoogleFonts.inter(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
