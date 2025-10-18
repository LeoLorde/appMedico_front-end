import 'package:app_med/models/client_model.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/screens/client/client_register_screen2.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:app_med/widgets/date_picker_field.dart';
import 'package:app_med/widgets/forms_header.dart';
import 'package:app_med/widgets/gender_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ClientRegisterScreen extends StatefulWidget {
  @override
  State<ClientRegisterScreen> createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
  DateTime? selectedDate;
  String? selectedGender;

  ClientModel client = ClientModel();

  TextEditingController cpfController = TextEditingController();

  void _onContinuePressed() {
    String cpf = cpfController.text;
    String dataNascimento = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : 'Data não selecionada';
    String genero = selectedGender ?? 'Nenhum gênero selecionado';

    if (genero == 'Masculino') {
      client.gender = 'MAN';
    } else if (genero == 'Feminino') {
      client.gender = 'WOMAN';
    } else if (genero == 'Indefinido') {
      client.gender = 'NONE';
    }

    client.cpf = cpf;
    client.dataDeNascimento = DateTime.tryParse(dataNascimento);

    print('CPF: $cpf');
    print('Data de Nascimento: $dataNascimento');
    print('Gênero: $genero');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClientRegisterScreen2(clientModel: client)),
    );
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
                      FormsHeader(title: "Bem-vindo!", subtitle: "Faça um cadastro"),
                      SizedBox(height: 40),
                      Container(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data de Nascimento',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            DatePickerField(
                              selectedDate: selectedDate,
                              onDateSelected: (DateTime newDate) {
                                setState(() {
                                  selectedDate = newDate;
                                });
                              },
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
                              'CPF',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: cpfController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: '123.456.789-00',
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
                              'Gênero',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            GenderSelector(
                              selectedGender: selectedGender,
                              onSelectGender: (gender) {
                                setState(() {
                                  selectedGender = gender;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      BlackButton(label: "Continuar", onPressed: () => {_onContinuePressed()}),
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
