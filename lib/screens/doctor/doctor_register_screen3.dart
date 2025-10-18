import 'package:app_med/connections/create_doctor.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/forms/auth_scaffold.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:flutter/material.dart';

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
    final response = createDoctor(doctor);
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
          FormsHeader(title: "Bem-Vindo!", subtitle: "Faça o seu cadastro"),
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
