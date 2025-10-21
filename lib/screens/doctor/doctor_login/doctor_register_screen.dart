import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/screens/doctor/doctor_login/doctor_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_login/doctor_register_screen2.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/forms/auth_scaffold.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorRegisterScreen extends StatefulWidget {
  @override
  State<DoctorRegisterScreen> createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends State<DoctorRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  void _handleContinue() {
    String name = _nameController.text;
    String specialty = _specialtyController.text;
    String bio = _bioController.text;

    DoctorModel doctor = DoctorModel(username: name, especialidade: specialty, bio: bio);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DoctorRegisterScreen2(doctor: doctor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogo(),
          SizedBox(height: 20),
          FormsHeader(title: 'Bem-vindo!', subtitle: 'Criar conta para Profissional'),
          SizedBox(height: 40),
          FormsTextField(label: 'Nome', hintText: 'Luísio de Azevedo', controller: _nameController),
          SizedBox(height: 20),
          Container(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Biografia',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _bioController,
                  maxLines: 5,
                  minLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Escreva um pouco sobre você...',
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
          FormsTextField(
            label: 'Especialidade',
            hintText: 'Dentista',
            controller: _specialtyController,
          ),
          SizedBox(height: 30),
          BlackButton(label: "Continuar", onPressed: _handleContinue),
          SizedBox(height: 60),
          LinkText(
            text: 'Já tem uma conta? Clique Aqui',
            fontSize: 20,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorLoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
