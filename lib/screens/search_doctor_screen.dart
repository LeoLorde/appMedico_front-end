import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/widgets/doctor_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchDoctorScreen extends StatefulWidget {
  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ache um Doutor',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Pesquisar',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          DoctorCard(
            doctor: DoctorModel(username: 'Lucas', especialidade: 'Cardiologista'),
            imageUrl: 'https://i.pravatar.cc/150?img=1', // imagem de teste
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
