bool validateClientFirstData({
  required String cpf,
  required String? selectedGender,
  required DateTime? selectedDate,
}) {
  String cleanCpf = cpf.replaceAll(RegExp(r'[.\-]'), '');

  if (cleanCpf.isEmpty) return false;
  if (selectedGender == null) return false;
  if (selectedDate == null) return false;

  if (cleanCpf.length != 11) return false;

  return true;
}
