import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/models/endereco_model.dart';
import 'package:app_med/screens/doctor/doctor_login_screen.dart';
import 'package:app_med/screens/doctor/doctor_register_screen3.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:app_med/widgets/forms_header.dart';
import 'package:app_med/widgets/forms_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorRegisterScreen2 extends StatefulWidget {
  final DoctorModel doctor;

  DoctorRegisterScreen2({required this.doctor});

  @override
  State<DoctorRegisterScreen2> createState() => _DoctorRegisterScreen2State();
}

class _DoctorRegisterScreen2State extends State<DoctorRegisterScreen2> {
  @override
  void initState() {
    super.initState();
    DoctorModel doctor = widget.doctor;
  }

  TextEditingController estadoController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _handleContinue() {
      DoctorModel doctor = widget.doctor;
      EnderecoModel endereco = EnderecoModel(
        estado: estadoController.text,
        cidade: cidadeController.text,
        rua: ruaController.text,
        cep: cepController.text,
        numero: numeroController.text,
        complemento: complementoController.text,
      );
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
                      FormsHeader(title: "Bem-Vindo!", subtitle: "Faça um cadastro"),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FormsTextField(
                            label: "Estado",
                            hintText: "Paraná",
                            controller: estadoController,
                          ),
                          SizedBox(width: 40),
                          FormsTextField(
                            label: "Cidade",
                            hintText: "Curitiba",
                            controller: cidadeController,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CEP',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: cepController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: '67442-038',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 40),
                          FormsTextField(
                            label: "Rua",
                            hintText: "Rua A",
                            controller: ruaController,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Número',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: ruaController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: '154',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 40),
                          FormsTextField(
                            label: "Complemento",
                            hintText: "Ao lado de ...",
                            controller: complementoController,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      BlackButton(label: "Continuar", onPressed: _handleContinue),
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DoctorLoginScreen()),
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
