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

  Future<void> _onRegisterPressed() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("As senhas não coincidem")));
      return;
    }

    clientModel.username = usernameController.text.trim();
    clientModel.email = emailController.text.trim();
    clientModel.senha = passwordController.text;

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogo(),
                const SizedBox(height: 20),
                const FormsHeader(title: 'Bem-vindo!', subtitle: 'Criar conta para Paciente'),
                const SizedBox(height: 30),

                // Campos de texto
                FormsTextField(
                  label: 'Nome',
                  hintText: 'Seu nome de usuário',
                  controller: usernameController,
                ),
                const SizedBox(height: 12),
                FormsTextField(
                  label: 'Email',
                  hintText: 'exemplo@gmail.com',
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                FormsTextField(
                  label: 'Senha',
                  hintText: '*********',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                FormsTextField(
                  label: 'Confirmar Senha',
                  hintText: '*********',
                  controller: confirmPasswordController,
                  obscureText: true,
                ),

                const SizedBox(height: 25),
                BlackButton(
                  label: "Cadastrar",
                  onPressed: () async {
                    await _onRegisterPressed();
                  },
                ),

                const SizedBox(height: 50),
                LinkText(
                  text: 'Já tem uma conta? Clique Aqui',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientLoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
