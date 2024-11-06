import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/autores/autor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_1/models/livros/livro_form.dart';
import 'package:hive/hive.dart';

class MockAutorBox extends Mock implements Box<Autor> {}

void main() {
  final mockAutorBox = MockAutorBox();

  setUp(() async {
    when(() => mockAutorBox.values).thenReturn([
      Autor(nome: 'Autor 1', nacionalidade: 'Brasileiro'),
      Autor(nome: 'Autor 2', nacionalidade: 'Americano'),
    ]);

    Hive.init('testPath');
    await Hive.openBox<Autor>('autores');
  });

  testWidgets('LivroForm deve exibir os campos corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LivroForm(),
      ),
    );

    expect(find.text('Adicionar Novo Livro'), findsOneWidget);
    expect(find.text('Nome do Livro'), findsOneWidget);
    expect(find.text('Descrição'), findsOneWidget);
    expect(find.text('Selecione um autor'), findsOneWidget);
  });
}
