import 'package:app_med/connections/login_doctor.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_register_screen.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/forms/auth_scaffold.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:app_med/widgets/buttons/white_button.dart';
import 'package:flutter/material.dart';

class DoctorLoginScreen extends StatefulWidget {
  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void _handleLogin() async {
    final response = await loginDoctor(email: emailController.text, senha: senhaController.text);
    if (response.containsKey("access_token")) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login funcionou")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo(),
          SizedBox(height: 20),
          FormsHeader(title: "Bem-Vindo!", subtitle: "Entrar como Profissional"),
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
            controller: senhaController,
            obscureText: true,
          ),
          SizedBox(height: 30),
          BlackButton(label: "Login", onPressed: _handleLogin),
          SizedBox(height: 20),
          WhiteButton(
            label: 'Criar Conta',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorRegisterScreen()),
              );
            },
          ),
          SizedBox(height: 90),
          LinkText(
            text: 'É um cliente? Clique Aqui',
            fontSize: 20,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClientLoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
