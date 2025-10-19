import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;

  const AuthScaffold({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight;

    final verticalPadding = availableHeight * 0.02;
    final horizontalPadding = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AuthAppBar(title: "DoctorHub", onBackTap: () => Navigator.pop(context)),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding.clamp(10.0, 40.0),
                      horizontal: horizontalPadding.clamp(16.0, 32.0),
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
