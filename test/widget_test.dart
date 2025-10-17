import 'package:test/test.dart';
import 'package:intl/intl.dart';
import 'package:app_med/models/client_model.dart';

void main() {
  group('ClientModel', () {
    test('Deve criar um cliente corretamente', () {
      final dataNascimento = DateTime(1990, 5, 20);
      final client = ClientModel(
        username: 'joao123',
        dataDeNascimento: dataNascimento,
        gender: 'Masculino',
        senha: 'senha123',
        cpf: '123.456.789-00',
        email: 'joao@email.com',
      );

      expect(client.username, 'joao123');
      expect(client.dataDeNascimento, dataNascimento);
      expect(client.gender, 'Masculino');
      expect(client.senha, 'senha123');
      expect(client.cpf, '123.456.789-00');
      expect(client.email, 'joao@email.com');
    });

    test('dataFormatada() deve formatar a data corretamente', () {
      final dataNascimento = DateTime(1990, 5, 20);
      final client = ClientModel(
        username: 'joao123',
        dataDeNascimento: dataNascimento,
        gender: 'Masculino',
        senha: 'senha123',
        cpf: '123.456.789-00',
        email: 'joao@email.com',
      );

      final dataFormatada = client.dataFormatada();
      final expectedDataFormatada = DateFormat('yyyy-MM-dd').format(dataNascimento);

      expect(dataFormatada, expectedDataFormatada);
    });

    test('toMap() deve retornar um mapa correto', () {
      final dataNascimento = DateTime(1990, 5, 20);
      final client = ClientModel(
        username: 'joao123',
        dataDeNascimento: dataNascimento,
        gender: 'Masculino',
        senha: 'senha123',
        cpf: '123.456.789-00',
        email: 'joao@email.com',
      );

      final map = client.toMap();

      expect(map['username'], 'joao123');
      expect(map['dataDeNascimento'], '1990-05-20');
      expect(map['gender'], 'Masculino');
      expect(map['senha'], 'senha123');
      expect(map['cpf'], '123.456.789-00');
      expect(map['email'], 'joao@email.com');
    });

    test('fromMap() deve criar um ClientModel correto', () {
      final map = {
        'username': 'joao123',
        'dataDeNascimento': '1990-05-20',
        'gender': 'Masculino',
        'senha': 'senha123',
        'cpf': '123.456.789-00',
        'email': 'joao@email.com',
      };

      final client = ClientModel.fromMap(map);

      expect(client.username, 'joao123');
      expect(client.dataDeNascimento, DateTime(1990, 5, 20));
      expect(client.gender, 'Masculino');
      expect(client.senha, 'senha123');
      expect(client.cpf, '123.456.789-00');
      expect(client.email, 'joao@email.com');
    });
  });
}
