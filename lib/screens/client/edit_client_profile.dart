import 'package:app_med/models/client_model.dart';
import 'package:app_med/widgets/gender/gender_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_med/utils/responsive_helper.dart';

class EditProfileScreen extends StatefulWidget {
  final ClientModel client;

  const EditProfileScreen({super.key, required this.client});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil", style: GoogleFonts.inter(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.width(24),
          vertical: responsive.height(16),
        ),
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
                      radius: responsive.width(55),
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : const AssetImage('assets/images/logo.png') as ImageProvider,
                    ),
                    Container(
                      width: responsive.width(110),
                      height: responsive.width(110),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: responsive.fontSize(32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: responsive.height(24)),

            // Campos editáveis
            _buildEditableField("Nome", nameController, Icons.edit, responsive),
            _buildEditableField("Email", emailController, Icons.edit, responsive),
            _buildPasswordField('Nova senha', passwordController, responsive),
            _buildPasswordField('Confirmar senha', confirmPasswordController, responsive),

            SizedBox(height: responsive.height(16)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Gênero",
                style: GoogleFonts.inter(
                  fontSize: responsive.fontSize(16),
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: responsive.height(8)),

            // Seletor de gênero
            GenderSelector(
              selectedGender: selectedGender,
              onSelectGender: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),

            SizedBox(height: responsive.height(28)),

            // Botão confirmar
            SizedBox(
              width: double.infinity,
              height: responsive.height(48),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "Salvar",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: responsive.fontSize(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    IconData icon,
    ResponsiveHelper responsive,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsive.height(16)),
      child: TextField(
        controller: controller,
        style: GoogleFonts.inter(fontSize: responsive.fontSize(16)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(fontSize: responsive.fontSize(16)),
          suffixIcon: Icon(icon, size: responsive.fontSize(20)),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    ResponsiveHelper responsive,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsive.height(16)),
      child: TextField(
        controller: controller,
        obscureText: obscurePassword,
        style: GoogleFonts.inter(fontSize: responsive.fontSize(16)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(fontSize: responsive.fontSize(16)),
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
              size: responsive.fontSize(20),
            ),
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
