import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorLoginScreen extends StatefulWidget {
  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/3774/3774299.png',
              height: 100,
              width: 100,
            ),
            Text(
              'Doctor Hub',
              style: GoogleFonts.inter(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Escolha o tipo de usuário',
              style: GoogleFonts.inter(color: Colors.black, fontSize: 15),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
