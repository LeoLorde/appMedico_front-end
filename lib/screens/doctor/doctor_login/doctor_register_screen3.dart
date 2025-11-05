import 'package:app_med/connections/doctor/create_doctor.dart';
import 'package:app_med/connections/doctor/login_doctor.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/screens/client/client_login/client_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_home_screen.dart';
import 'package:app_med/screens/doctor/doctor_login/finish_profile_screen.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/forms/auth_scaffold.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DoctorRegisterScreen3 extends StatefulWidget {
  DoctorModel doctor;

  DoctorRegisterScreen3(this.doctor);
  @override
  State<DoctorRegisterScreen3> createState() => _DoctorRegisterScreen3State();
}

class _DoctorRegisterScreen3State extends State<DoctorRegisterScreen3> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConfController = TextEditingController();

  Future<void> _handleCadastro() async {
    DoctorModel doctor = widget.doctor;
    doctor.email = emailController.text;
    if (senhaController.text != senhaConfController.text) {
      return;
    }

    doctor.senha = senhaConfController.text;
    final response = await createDoctor(doctor);
    final response2 = await loginDoctor(email: emailController.text, senha: senhaController.text);
    if (response.containsKey("access_token")) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login funcionou")));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', response['access_token']);
      await prefs.setString('username', response['user']['username']);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => FinishProfileScreen()));
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo(),
          SizedBox(height: 20),
          FormsHeader(title: "Bem-Vindo!", subtitle: "Criar conta para Profissional"),
          SizedBox(height: 40),
          FormsTextField(
            label: "Email",
            hintText: "example@example.gmail",
            controller: emailController,
          ),
          SizedBox(height: 20),
          FormsTextField(
            label: "Senha",
            hintText: "***********",
            controller: senhaController,
            obscureText: true,
          ),
          SizedBox(height: 20),
          FormsTextField(
            label: "Confirmar Senha",
            hintText: "*********",
            controller: senhaConfController,
            obscureText: true,
          ),
          SizedBox(height: 30),
          BlackButton(label: "Cadastrar", onPressed: _handleCadastro),
          SizedBox(height: 60),
          LinkText(
            text: 'Já tem uma conta? Clique Aqui',
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
