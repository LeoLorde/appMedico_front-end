import 'package:app_med/models/client_model.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/screens/client/client_register_screen2.dart';
import 'package:app_med/utils/parser/cpf_formatter.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/auth_scaffold.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:app_med/widgets/date_picker_field.dart';
import 'package:app_med/widgets/forms_field_label.dart';
import 'package:app_med/widgets/forms_header.dart';
import 'package:app_med/widgets/forms_text_field.dart';
import 'package:app_med/widgets/gender_selector.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:flutter/material.dart';
import 'package:app_med/utils/parser/gender_parse.dart';
import 'package:app_med/utils/validator/client_register_validator.dart';
import 'package:flutter/services.dart';

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

    if (!validateClientFirstData(
      cpf: cpf,
      selectedGender: selectedGender,
      selectedDate: selectedDate,
    )) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Por favor, preencha todos os campos corretamente.')));
      return;
    }

    client.cpf = cpf;
    client.gender = genderParse(selectedGender);
    client.dataDeNascimento = selectedDate;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClientRegisterScreen2(clientModel: client)),
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
          FormsHeader(title: "Bem-vindo!", subtitle: "Faça um cadastro"),
          SizedBox(height: 40),
          Container(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormsFieldLabel(text: "Data de nascimento"),
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
          FormsTextField(
            label: "CPF",
            hintText: "123.456.789-00",
            controller: cpfController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()],
          ),
          SizedBox(height: 20),
          Container(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormsFieldLabel(text: "Gênero"),
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
          BlackButton(label: "Continuar", onPressed: _onContinuePressed),
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
