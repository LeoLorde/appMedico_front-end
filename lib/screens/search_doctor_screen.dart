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
        padding: EdgeInsets.all(12),
        children: [
          ElevatedButton(
            onPressed: () async {
              List<DoctorModel> fetchedDoctors = await getDoctor(username: controller.text);
              print("${controller.text}");
              print(fetchedDoctors.length);
              setState(() {
                doctors = fetchedDoctors;
              });
            },
            child: Text("FETCH"),
          ),

          doctors.isEmpty
              ? Center(child: Text('Nenhum doutor encontrado.'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
