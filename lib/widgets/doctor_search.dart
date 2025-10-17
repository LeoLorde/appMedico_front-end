import 'package:flutter/material.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final String imageUrl;
  final double distance; // calcular depois usando enderecoId

  const DoctorCard({Key? key, required this.doctor, required this.imageUrl, this.distance = 0.0})
    : super(key: key);

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
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 4),
                  Text(
                    doctor.especialidade ?? '',
                    style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text('5.0', style: GoogleFonts.inter(fontSize: 18)),
                      SizedBox(width: 20),
                      Text('|'),
                      SizedBox(width: 18),
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${distance.toStringAsFixed(1)} KM',
                        style: GoogleFonts.inter(fontSize: 18),
                      ),
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
