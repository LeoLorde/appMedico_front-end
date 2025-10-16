import 'package:app_med/connections/create_client.dart';
import 'package:app_med/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController senhaController = TextEditingController();

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
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  label: Text('Data de Nascimento'),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : 'Selecione a data',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(label: Text('Senha')),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor, selecione a data de nascimento',
                      ),
                    ),
                  );
                  return;
                }

                final client = ClientModel(
                  username: nomeController.text,
                  dataDeNascimento: selectedDate!,
                  gender: generoController.text,
                  senha: senhaController.text,
                  cpf: cpfController.text,
                  email: emailController.text,
                );

                final response = await createClient(client);

                print('Cliente criado: ${client.toMap()}');
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
