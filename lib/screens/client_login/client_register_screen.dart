import 'package:app_med/models/client_model.dart';
import 'package:app_med/screens/client_login/client_login_screen.dart';
import 'package:app_med/screens/client_login/client_register_screen2.dart';
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

  ClientModel client;

  TextEditingController cpfController = TextEditingController();

  Widget _buildGenderButton(String gender) {
    final bool isSelected = selectedGender == gender;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = gender;
            });
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Text(
                gender,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3774/3774299.png',
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        'Bem-vindo!',
                        style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Faça um cadastro',
                        style: GoogleFonts.inter(color: Colors.black, fontSize: 20),
                      ),
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
                            InkWell(
                              onTap: () => _selectDate(context),
                              child: InputDecorator(
                                decoration: InputDecoration(
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
                                  suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
                                ),
                                child: Text(
                                  selectedDate != null
                                      ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                      : 'Selecione a data',
                                  style: GoogleFonts.inter(
                                    color: selectedDate != null ? Colors.black : Colors.black,
                                    fontSize: 16,
                                  ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildGenderButton('Masculino'),
                                _buildGenderButton('Feminino'),
                                _buildGenderButton('Indefinido'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          String cpf = cpfController.text;
                          String dataNascimento = selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : 'Data não selecionada';
                          String genero = selectedGender ?? 'Nenhum gênero selecionado';

                          print('CPF: $cpf');
                          print('Data de Nascimento: $dataNascimento');
                          print('Gênero: $genero');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ClientRegisterScreen2()),
                          );
                        },
                        child: Text(
                          'Continuar',
                          style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(350, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
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
