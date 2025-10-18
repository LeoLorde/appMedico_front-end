String genderParse(String? selectedGender) {
  switch (selectedGender) {
    case 'Masculino':
      return 'MAN';
    case 'Feminino':
      return 'WOMAN';
    case 'Indefinido':
      return 'NONE';
    default:
      return 'NONE';
  }
}
