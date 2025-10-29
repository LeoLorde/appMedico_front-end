import 'package:app_med/screens/doctor/doctor_home_screen.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:flutter/material.dart';

class ResgisterCompleted extends StatelessWidget {
  const ResgisterCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Círculo com o check verde
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(color: const Color(0xFFDFFFE0), shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 50, color: Color(0xFF00B23E)),
                ),
                const SizedBox(height: 30),

                // Título
                const Text(
                  "Perfil Completo",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),

                const SizedBox(height: 8),

                // Subtítulo
                const Text(
                  "Seu perfil foi concluído com sucesso!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // Botão
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: BlackButton(
                    label: 'Começar agora!',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorHomeScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
