import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_1/models/autores/autor.dart';
import 'package:flutter_application_1/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('Teste de criação de autor', () {
    late ApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    test('Testa a criação de um autor', () async {
      final autor = Autor(
        id: '670aef08-1fcd-4ead-989c-ff7b7f384c56',
        nome: 'J.K. Rowling',
        nacionalidade: 'Britânica',
      );

      when(() => mockApiService.addAutor(autor)).thenAnswer((_) async {});

      await mockApiService.addAutor(autor);

      verify(() => mockApiService.addAutor(autor)).called(1);

      expect(autor.nome, 'J.K. Rowling');
      expect(autor.nacionalidade, 'Britânica');
    });
  });
}
