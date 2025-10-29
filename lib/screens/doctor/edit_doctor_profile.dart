import 'package:app_med/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditDoctorProfile extends StatefulWidget {
  final DoctorModel doctor;

  const EditDoctorProfile({super.key, required this.doctor});

  @override
  State<EditDoctorProfile> createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController crmController;
  late TextEditingController startController;
  late TextEditingController endController;
  late TextEditingController lunchStartController;
  late TextEditingController lunchEndController;

  List<String> selectedDays = [];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.doctor.username ?? '');
    emailController = TextEditingController(text: widget.doctor.email ?? '');
    crmController = TextEditingController(text: widget.doctor.crm ?? '');
    startController = TextEditingController(text: widget.doctor.startHour ?? '');
    endController = TextEditingController(text: widget.doctor.endHour ?? '');
    lunchStartController = TextEditingController(text: widget.doctor.lunchStart ?? '');
    lunchEndController = TextEditingController(text: widget.doctor.lunchEnd ?? '');

    selectedDays = widget.doctor.workDays ?? [];
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      final formatted = pickedTime.format(context);
      setState(() {
        controller.text = formatted;
      });
    }
  }

  void _toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage('assets/images/logo.png') as ImageProvider,
                  ),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildEditableField("Nome", nameController),
            _buildEditableField("Email", emailController),
            _buildEditableField("CRM", crmController),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dias de Expediente",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: daysOfWeek.map((day) {
                final isSelected = selectedDays.contains(day);
                return ChoiceChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (_) => _toggleDay(day),
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  backgroundColor: Colors.grey.shade200,
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            _buildTimePickerField("Início do Expediente", startController),
            _buildTimePickerField("Fim do Expediente", endController),
            _buildTimePickerField("Início do Almoço", lunchStartController),
            _buildTimePickerField("Fim do Almoço", lunchEndController),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // salvar aqui
                  print("Nome: ${nameController.text}");
                  print("Dias: $selectedDays");
                  print("Início: ${startController.text} - Fim: ${endController.text}");
                  print("Almoço: ${lunchStartController.text} - ${lunchEndController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.edit, size: 20),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTimePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _pickTime(controller),
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.access_time, size: 20),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
