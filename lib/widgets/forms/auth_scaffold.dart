import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;

  const AuthScaffold({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AuthAppBar(title: "DoctorHub", onBackTap: () => Navigator.pop(context)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Align(
                alignment: Alignment.center,
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 120), child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
