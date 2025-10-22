import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(title: "Perguntas frequentes", onBackTap: () => Navigator.pop(context)),
    );
  }
}
