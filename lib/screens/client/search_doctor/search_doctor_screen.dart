import 'dart:async';
import 'package:app_med/connections/doctor/search_doctor.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/widgets/cards/doctor_search_card.dart';
import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:app_med/widgets/header/search_app_bar.dart';
import 'package:flutter/material.dart';

class SearchDoctorScreen extends StatefulWidget {
  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  List<DoctorModel> doctors = [];
  TextEditingController controller = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () async {
      final query = controller.text.trim();
      if (query.isEmpty) {
        setState(() => doctors = []);
        return;
      }

      // Faz o fetch
      List<DoctorModel> fetchedDoctors = await getDoctor(username: query);
      print("Buscando por: $query | Encontrados: ${fetchedDoctors.length}");
      setState(() {
        doctors = fetchedDoctors;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthAppBar(title: 'Ache um doutor', onBackTap: () => Navigator.pop(context)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Pesquisar',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: doctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 70, color: Colors.grey),
                        SizedBox(height: 20),
                        Text(
                          'Nenhum doutor encontrado.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return DoctorSearchCard(doctor: doctor, imageUrl: '');
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
