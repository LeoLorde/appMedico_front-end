import 'package:app_med/models/client_model.dart';
import 'package:app_med/widgets/gender/gender_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditDoctorProfile extends StatefulWidget {
  final ClientModel client;

  const EditDoctorProfile({super.key, required this.client});

  @override
  State<EditDoctorProfile> createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  String? selectedGender;
  bool obscurePassword = true;
  File? _imageFile;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.client.username ?? '');
    emailController = TextEditingController(text: widget.client.email ?? '');
    passwordController = TextEditingController(text: widget.client.senha ?? '');
    confirmPasswordController = TextEditingController(text: widget.client.senha ?? '');
    selectedGender = widget.client.gender ?? 'Indefinido';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            // Foto do perfil
            Center(
              child: GestureDetector(
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
            ),
            const SizedBox(height: 24),

            // Campos editáveis
            _buildEditableField("Nome", nameController, Icons.edit),
            _buildEditableField("Email", emailController, Icons.edit),
            _buildPasswordField('Nova senha', passwordController),
            _buildPasswordField('Confirmar senha', confirmPasswordController),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Gênero", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            ),
            const SizedBox(height: 8),

            // Seletor de gênero
            GenderSelector(
              selectedGender: selectedGender,
              onSelectGender: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),

            const SizedBox(height: 28),

            // Botão confirmar
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
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

  Widget _buildEditableField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(icon, size: 20),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscurePassword,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, size: 20),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
