import 'package:app_med/connections/login_doctor.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_register_screen.dart';
import 'package:app_med/screens/home_screen.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:app_med/widgets/forms_header.dart';
import 'package:app_med/widgets/forms_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorLoginScreen extends StatefulWidget {
  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  @override
  Widget build(BuildContext context) {
    void _handleRedirect() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorRegisterScreen()));
    }

    TextEditingController emailController = TextEditingController();
    TextEditingController senha = TextEditingController();

    void _handleLogin() async {
      final response = await loginDoctor(email: emailController.text, senha: senha.text);
      if (response.containsKey("access_token")) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login funcionou")));
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
                      FormsTextField(
                        label: "Email",
                        hintText: "example@example.com",
                        controller: emailController,
                      ),
                      SizedBox(height: 20),
                      FormsTextField(
                        label: "Senha",
                        hintText: "*******",
                        controller: senha,
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      BlackButton(
                        label: "Login",
                        onPressed: () async {
                          _handleLogin();
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _handleRedirect();
                        },
                        child: Text(
                          'Criar Conta',
                          style: GoogleFonts.inter(fontSize: 20, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 90),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ClientLoginScreen()),
                          ),
                        },
                        child: Text(
                          'É um cliente? Clique Aqui',
                          style: GoogleFonts.inter(
                            fontSize: 20,
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
