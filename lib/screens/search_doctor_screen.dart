import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/widgets/doctor_search.dart';
import 'package:app_med/widgets/header/search_app_bar.dart';
import 'package:flutter/material.dart';

class SearchDoctorScreen extends StatefulWidget {
  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchAppBar(title: 'Ache um Doutor', onBackPressed: () => Navigator.pop(context)),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          DoctorCard(
            doctor: DoctorModel(username: 'Lucas', especialidade: 'Cardiologista'),
            imageUrl: 'https://i.pravatar.cc/150?img=1',
            distance: 3.2,
          ),
          DoctorCard(
            doctor: DoctorModel(username: 'Ana', especialidade: 'Dermatologista'),
            imageUrl: 'https://i.pravatar.cc/150?img=2',
            distance: 5.7,
          ),
          DoctorCard(
            doctor: DoctorModel(username: 'Rafael', especialidade: 'Ortopedista'),
            imageUrl: 'https://i.pravatar.cc/150?img=3',
            distance: 2.0,
          ),
        ],
      ),
    );
  }
}
