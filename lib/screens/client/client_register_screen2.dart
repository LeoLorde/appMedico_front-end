import 'package:app_med/connections/create_client.dart';
import 'package:app_med/models/client_model.dart';
import 'package:app_med/screens/client/client_login_screen.dart';
import 'package:app_med/widgets/black_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void _onRegisterPressed() {
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
    createClient(clientModel);
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    String? hint,
  }) {
    return Container(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset('assets/images/logo.png', width: 120, height: 120),
              SizedBox(height: 10),
              Text(
                'Bem-vindo!',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text('Faça um cadastro', style: GoogleFonts.inter(color: Colors.black, fontSize: 18)),
              SizedBox(height: 20),
              _buildTextField('Nome', usernameController, hint: 'Seu nome de usuário'),
              SizedBox(height: 12),
              _buildTextField(
                'Email',
                emailController,
                keyboardType: TextInputType.emailAddress,
                hint: 'exemplo@gmail.com',
              ),
              SizedBox(height: 12),
              _buildTextField('Senha', passwordController, obscure: true, hint: '*********'),
              SizedBox(height: 12),
              _buildTextField(
                'Confirmar Senha',
                confirmPasswordController,
                obscure: true,
                hint: '*********',
              ),
              SizedBox(height: 20),
              BlackButton(label: "Cadastrar", onPressed: _onRegisterPressed),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientLoginScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Já tem uma conta? Clique Aqui',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
