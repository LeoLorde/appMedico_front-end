import 'package:app_med/connections/login_client.dart';
import 'package:app_med/screens/client/client_register_screen.dart';
import 'package:app_med/screens/doctor/doctor_login_screen.dart';
import 'package:app_med/screens/home_screen.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/forms/auth_scaffold.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:app_med/widgets/buttons/white_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientLoginScreen extends StatefulWidget {
  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      final response = await loginClient(email: email, senha: password);

      if (!response.containsKey("access_token")) {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro no login: $e")));
      print("Erro no login: $e");
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
          FormsHeader(title: "Bem-Vindo!", subtitle: "Faça login na sua conta"),
          SizedBox(height: 40),
          FormsTextField(
            label: "Email",
            hintText: "exemplo@gmail.com",
            controller: _emailController,
          ),
          SizedBox(height: 20),
          FormsTextField(
            label: "Senha",
            hintText: "********",
            controller: _passwordController,
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
                MaterialPageRoute(builder: (context) => ClientRegisterScreen()),
              );
            },
          ),
          SizedBox(height: 90),
          LinkText(
            text: 'É um profissional? Clique Aqui',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorLoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
