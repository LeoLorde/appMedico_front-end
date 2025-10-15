import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(label: Text('Nome')),
            ),
            TextField(
              controller: cpfController,
              decoration: const InputDecoration(label: Text('CPF')),
            ),
            TextField(
              controller: generoController,
              decoration: const InputDecoration(label: Text('Gênero')),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(label: Text('Email')),
            ),
            TextField(
              controller: dataNascimentoController,
              decoration: const InputDecoration(
                label: Text('Data de Nascimento'),
              ),
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(label: Text('Senha')),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Nome: ${nomeController.text}');
                print('CPF: ${cpfController.text}');
                print('Gênero: ${generoController.text}');
                print('Email: ${emailController.text}');
                print('Data de Nascimento: ${dataNascimentoController.text}');
                print('Senha: ${senhaController.text}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }
}
