import 'package:app_med/screens/client/client_login/client_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_login/doctor_login_screen.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/cards/user_type_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitScreen extends StatefulWidget {
  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(),
            SizedBox(height: 20),
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
            UserTypeCard(
              icon: Icons.person,
              title: 'Paciente',
              subtitle: 'Marcar horário',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientLoginScreen()),
                );
              },
            ),
            UserTypeCard(
              icon: Icons.medical_services,
              title: 'Profissional',
              subtitle: 'Gerenciar horários',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorLoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
