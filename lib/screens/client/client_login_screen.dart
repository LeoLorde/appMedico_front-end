import 'package:app_med/connections/login_client.dart';
import 'package:app_med/screens/client/client_register_screen.dart';
import 'package:app_med/screens/doctor_login/doctor_login_screen.dart';
import 'package:app_med/screens/home_screen.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:app_med/widgets/forms_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientLoginScreen extends StatefulWidget {
  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _handleLogin() async {
      try {
        final email = _emailController.text;
        final password = _passwordController.text;

        final response = await loginClient(email: email, senha: password);

        if (response == null || !response.containsKey("access_token")) {
          // API retornou erro
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login falhou! Verifique email e senha.")));
          return;
        }

        final access_token = response["access_token"];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', access_token);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        // Mostra erro caso algo dê errado
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro no login: $e")));
        print("Erro no login: $e");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png', width: 120, height: 120),
                      SizedBox(height: 20),
                      FormsHeader(title: "Bem-Vindo!", subtitle: "Faça login na sua conta"),
                      SizedBox(height: 40),
                      Container(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'exemplo@gmail.com',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senha',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '********',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      BlackButton(
                        label: "Login",
                        onPressed: () {
                          _handleLogin();
                        },
                      ),
                      SizedBox(height: 20),
                      BlackButton(
                        label: 'Criar Conta',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ClientRegisterScreen()),
                          );
                        },
                      ),
                      SizedBox(height: 90),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DoctorLoginScreen()),
                          );
                        },
                        child: Text(
                          'É um profissional? Clique Aqui',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
