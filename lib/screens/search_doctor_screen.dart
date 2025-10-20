import 'dart:async';
import 'package:app_med/connections/search_doctor.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/widgets/doctor_search.dart';
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
      appBar: SearchAppBar(
        title: 'Ache um Doutor',
        onBackPressed: () => Navigator.pop(context),
        controller: controller,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          doctors.isEmpty
              ? const Center(child: Text('Nenhum doutor encontrado.'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    DoctorModel doctor = doctors[index];
                    return DoctorCard(doctor: doctor, imageUrl: '');
                  },
                ),
        ],
      ),
    );
  }
}
