import 'package:app_med/connections/create_doctor.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:app_med/widgets/forms_header.dart';
import 'package:app_med/widgets/forms_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();
    DoctorModel doctor = widget.doctor;
  }

  Future<void> _handleCadastro() async {
    DoctorModel doctor = widget.doctor;
    doctor.email = emailController.text;
    if (senhaConfController.text != senhaConfController.text) {
      return;
    }

    doctor.senha = senhaConfController.text;
    final response = createDoctor(doctor);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
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
                      ),
                      SizedBox(height: 20),
                      FormsTextField(
                        label: "Confirmar Senha",
                        hintText: "*********",
                        controller: senhaConfController,
                      ),
                      SizedBox(height: 30),
                      BlackButton(
                        label: "Cadastrar",
                        onPressed: () async {
                          _handleCadastro();
                        },
                      ),
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ClientLoginScreen()),
                          );
                        },
                        child: Text(
                          'Já tem uma conta? Clique Aqui',
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
