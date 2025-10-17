import 'package:flutter/material.dart';
import 'gender_button.dart';

class GenderSelector extends StatelessWidget {
  final String? selectedGender;
  final Function(String) onSelectGender;

  const GenderSelector({required this.selectedGender, required this.onSelectGender});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.0,
      children: [
        GenderButton(
          label: 'Masculino',
          selected: selectedGender == 'Masculino',
          value: "MAN",
          onTap: () => onSelectGender('Masculino'),
        ),
        GenderButton(
          label: 'Feminino',
          selected: selectedGender == 'Feminino',
          value: "WOMAN",
          onTap: () => onSelectGender('Feminino'),
        ),
        GenderButton(
          label: 'Indefinido',
          selected: selectedGender == 'Indefinido',
          value: "UNDEFINED",
          onTap: () => onSelectGender('Indefinido'),
        ),
      ],
    );
  }
}
