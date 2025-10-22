import 'package:app_med/screens/client/client_calendar_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';

import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientConfigurationScreen extends StatefulWidget {
  @override
  State<ClientConfigurationScreen> createState() => _ClientConfigurationScreenState();
}

class _ClientConfigurationScreenState extends State<ClientConfigurationScreen> {
  bool _notificationsEnabled = false;

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ClientHomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ClientCalendarScreen()),
        );
        break;
      case 2:
        break;
      case 3:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Configurações',
        subtitle: 'Gerencie sua conta',
        avatarImage: 'assets/images/logo.png',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/images/logo.png')),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Luísio de Azevedo',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'medico@exemplo.com',
                        style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Editar Perfil'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Suporte
            Text(
              'Suporte',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Perguntas Frequentes'),
                subtitle: const Text('Encontre respostas rápidas'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: const Icon(Icons.report_problem_outlined),
                title: const Text('Relatar Problemas'),
                subtitle: const Text('Relate problemas'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),

            // Preferências
            Text(
              'Preferências',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: const Text('Notificações'),
                trailing: Switch(
                  activeColor: Colors.black,
                  value: _notificationsEnabled,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(val ? 'Notificações ativadas!' : 'Notificações desativadas.'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 3,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
