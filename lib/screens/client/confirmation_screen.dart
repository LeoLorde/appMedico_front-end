import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String address;

  const ConfirmationScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthAppBar(title: '', onBackTap: () => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // ÍCONE DE CONFIRMAÇÃO
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
              child: const Icon(Icons.check, color: Colors.green, size: 45),
            ),
            const SizedBox(height: 25),

            // TÍTULOS
            Text(
              'Pedido Confirmado',
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Seu pedido foi confirmado com sucesso!',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 25),

            // CARD DO DOUTOR
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info do médico
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            specialty,
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300),

                  // Data
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(date, style: GoogleFonts.inter(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Hora
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(time, style: GoogleFonts.inter(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Local
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18, color: Colors.black),
                      const SizedBox(width: 8),
                      Expanded(child: Text(address, style: GoogleFonts.inter(fontSize: 14))),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // BOTÃO VOLTAR
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientHomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Voltar ao Início',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
