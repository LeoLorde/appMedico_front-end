import 'package:app_med/screens/doctor/doctor_login/resgister_completed.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FinishProfileScreen extends StatefulWidget {
  const FinishProfileScreen({super.key});

  @override
  State<FinishProfileScreen> createState() => _FinishProfileScreenState();
}

class _FinishProfileScreenState extends State<FinishProfileScreen> {
  final TextEditingController crmController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController(text: "06:00");
  final TextEditingController endTimeController = TextEditingController(text: "18:00");
  final TextEditingController lunchStartController = TextEditingController();
  final TextEditingController lunchEndController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  final List<String> days = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"];
  Set<String> selectedDays = {};

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    final crm = crmController.text;
    final bio = bioController.text;
    final dias = selectedDays.join(', ');
    final horarios = {
      "inicio": startTimeController.text,
      "fim": endTimeController.text,
      "almoco_inicio": lunchStartController.text,
      "almoco_fim": lunchEndController.text,
    };

    debugPrint("CRM: $crm");
    debugPrint("Bio: $bio");
    debugPrint("Dias: $dias");
    debugPrint("Horários: $horarios");
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              AppLogo(),
              const SizedBox(height: 10),
              const Text("Seu Perfil", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text("Termine seu perfil para começar", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 60, color: Colors.grey)
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: crmController,
                decoration: InputDecoration(
                  labelText: "CRM",
                  hintText: "123456/SC",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),

              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Adicionar Expediente",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                children: days.map((d) {
                  final isSelected = selectedDays.contains(d);
                  return ChoiceChip(
                    label: Text(d),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selected ? selectedDays.add(d) : selectedDays.remove(d);
                      });
                    },
                    selectedColor: Colors.black,
                    checkmarkColor: Colors.white,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  );
                }).toList(),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: startTimeController,
                      decoration: const InputDecoration(labelText: "Início"),
                      readOnly: true,
                      onTap: () => _pickTime(startTimeController),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: endTimeController,
                      decoration: const InputDecoration(labelText: "Fim"),
                      readOnly: true,
                      onTap: () => _pickTime(endTimeController),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Horário de Almoço (opcional)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: lunchStartController,
                      decoration: const InputDecoration(labelText: "Início do Almoço"),
                      readOnly: true,
                      onTap: () => _pickTime(lunchStartController),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: lunchEndController,
                      decoration: const InputDecoration(labelText: "Fim do Almoço"),
                      readOnly: true,
                      onTap: () => _pickTime(lunchEndController),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              TextField(
                controller: bioController,
                maxLength: 200,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Descreva sua bio...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: BlackButton(
                  label: 'Concluir',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResgisterCompleted()),
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
