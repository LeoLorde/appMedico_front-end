import 'package:app_med/connections/create_address.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/models/endereco_model.dart';
import 'package:app_med/screens/doctor/doctor_login/doctor_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_login/doctor_register_screen3.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/forms/auth_scaffold.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorRegisterScreen2 extends StatefulWidget {
  final DoctorModel doctor;

  DoctorRegisterScreen2({required this.doctor});

  @override
  State<DoctorRegisterScreen2> createState() => _DoctorRegisterScreen2State();
}

class _DoctorRegisterScreen2State extends State<DoctorRegisterScreen2> {
  TextEditingController estadoController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();

  Future<void> _handleContinue() async {
    print("faz alguma coisa caralho");
    DoctorModel doctor = widget.doctor;
    EnderecoModel endereco = EnderecoModel(
      estado: estadoController.text,
      cidade: cidadeController.text,
      rua: ruaController.text,
      cep: cepController.text,
      numero: numeroController.text,
      complemento: complementoController.text,
    );
    print("esperando address");
    final response = await createAdress(endereco);
    if (response.containsKey("Error")) {
      print("erro de miearda: ${response["Error"]}");
      return;
    }
    print("foi address");
    doctor.enderecoId = response["address"];
    print(doctor.bio);
    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorRegisterScreen3(doctor)));
  }

  Widget _buildSmallTextField(String label, String hint, TextEditingController controller) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
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
          FormsHeader(title: "Bem-Vindo!", subtitle: "Criar conta para Profissional"),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                child: FormsTextField(
                  label: "Estado",
                  hintText: "Paraná",
                  controller: estadoController,
                ),
              ),
              SizedBox(width: 40),
              Container(
                width: 150,
                child: FormsTextField(
                  label: "Cidade",
                  hintText: "Curitiba",
                  controller: cidadeController,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallTextField('CEP', '67442-038', cepController),
              SizedBox(width: 40),
              Container(
                width: 160,
                child: FormsTextField(label: "Rua", hintText: "Rua A", controller: ruaController),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallTextField('Número', '154', numeroController),
              SizedBox(width: 40),
              Container(
                width: 160,
                child: FormsTextField(
                  label: "Complemento",
                  hintText: "Ao lado de ...",
                  controller: complementoController,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          BlackButton(
            label: "Continuar",
            onPressed: () async {
              await _handleContinue();
            },
          ),
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
