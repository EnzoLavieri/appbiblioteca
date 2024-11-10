import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_application_1/models/autores/autor.dart';
import 'package:flutter_application_1/services/api_service.dart';

void main() {
  test('Testa a criação de um autor', () {
    final autor = Autor(
      id: Uuid().v4(),
      nome: 'Autor Teste',
      nacionalidade: 'Brasil',
    );

    final apiService = ApiService();

    apiService.addAutor(autor);

    expect(autor.nome, 'Autor Teste');
    expect(autor.nacionalidade, 'Brasil');
  });

  test('Testa a criação de um autor', () {
    final autor = Autor(
      id: Uuid().v4(),
      nome: 'Autor Teste',
      nacionalidade: 'Brasil',
    );

    final apiService = ApiService();

    apiService.addAutor(autor);

    expect(autor.nome, 'Autor Teste');
    expect(autor.nacionalidade, 'Brasil');
  });
}
