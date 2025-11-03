import 'package:app_med/connections/client/create_client.dart';
import 'package:app_med/models/client_model.dart';
import 'package:app_med/screens/client/client_login/client_login_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
import 'package:app_med/widgets/link_text.dart';
import 'package:flutter/material.dart';

class ClientRegisterScreen2 extends StatefulWidget {
  final ClientModel? clientModel;

  const ClientRegisterScreen2({Key? key, this.clientModel}) : super(key: key);

  @override
  State<ClientRegisterScreen2> createState() => _ClientRegisterScreen2State();
}

class _ClientRegisterScreen2State extends State<ClientRegisterScreen2> {
  late ClientModel clientModel;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel ?? ClientModel();

    usernameController.text = clientModel.username ?? '';
    emailController.text = clientModel.email ?? '';
    passwordController.text = clientModel.senha ?? '';
    confirmPasswordController.text = clientModel.senha ?? '';
  }

  void _onRegisterPressed() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("As senhas não coincidem")));
      return;
    }
    clientModel.username = usernameController.text.trim();
    clientModel.email = emailController.text.trim();
    clientModel.senha = passwordController.text;
    print(clientModel.toMap());
    final response = await createClient(clientModel);
    print(response);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ClientHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              AppLogo(),
              SizedBox(height: 10),
              FormsHeader(title: 'Bem-vindo!', subtitle: 'Criar conta para Paciente'),
              SizedBox(height: 20),
              FormsTextField(
                label: 'Nome',
                hintText: 'Seu nome de usuário',
                controller: usernameController,
              ),
              SizedBox(height: 12),
              FormsTextField(
                label: 'Email',
                hintText: 'exemplo@gmail.com',
                controller: emailController,
              ),
              SizedBox(height: 12),
              FormsTextField(
                label: 'Senha',
                hintText: '*********',
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 12),
              FormsTextField(
                label: 'Confirmar Senha',
                hintText: '*********',
                controller: confirmPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              BlackButton(label: "Cadastrar", onPressed: _onRegisterPressed),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: LinkText(
                  text: 'Já tem uma conta? Clique Aqui',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientLoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
