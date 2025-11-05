import 'package:app_med/screens/doctor/doctor_login/resgister_completed.dart';
import 'package:app_med/widgets/app_logo.dart';
import 'package:app_med/widgets/buttons/black_button.dart';
import 'package:app_med/widgets/forms/forms_header.dart';
import 'package:app_med/widgets/forms/forms_text_field.dart';
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
  final TextEditingController timeController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
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
    final tempo = timeController.text;
    final dias = selectedDays.join(', ');
    final horarios = {
      "inicio": startTimeController.text,
      "fim": endTimeController.text,
      "almoco_inicio": lunchStartController.text,
      "almoco_fim": lunchEndController.text,
    };

    debugPrint("CRM: $crm");
    debugPrint("Tempo: $tempo");
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
              FormsHeader(title: "Bem-Vindo!", subtitle: "Criar conta para Profissional"),

              const SizedBox(height: 50),

              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.person, size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 45),

              FormsTextField(label: "CRM", hintText: "123456/SC", controller: crmController),

              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Adicionar Expediente",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FormsTextField(
                      label: "Início",
                      hintText: "08:00",
                      controller: startTimeController,
                      readOnly: true,
                      onTap: () => _pickTime(startTimeController),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: FormsTextField(
                      label: "Fim",
                      hintText: "18:00",
                      controller: endTimeController,
                      readOnly: true,
                      onTap: () => _pickTime(endTimeController),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Horário de almoço (opcional)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),

              // HORÁRIOS DE ALMOÇO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FormsTextField(
                      label: "Início",
                      hintText: "12:00",
                      controller: lunchStartController,
                      readOnly: true,
                      onTap: () => _pickTime(lunchStartController),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: FormsTextField(
                      label: "Fim",
                      hintText: "13:00",
                      controller: lunchEndController,
                      readOnly: true,
                      onTap: () => _pickTime(lunchEndController),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tempo médio por consulta",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: timeController,
                decoration: InputDecoration(
                  hintText: "20 minutos",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black),
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
