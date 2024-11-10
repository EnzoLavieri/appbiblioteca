// import 'package:flutter_application_1/models/autores/autor.dart';
// import 'package:flutter_application_1/models/livros/livro.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:hive/hive.dart';

// class MockBox<T> extends Mock implements Box<T> {}

// void main() {
//   late Box<Livro> mockLivroBox;
//   late Autor autorExemplo;

//   setUp(() {
//     mockLivroBox = MockBox<Livro>();
//     autorExemplo = Autor(nome: 'Autor Exemplo', nacionalidade: 'Brasileiro');
//   });

//   test('Deve salvar um novo livro na box', () async {
//     final livro = Livro(
//       nome: 'Novo Livro',
//       descricao: 'Descrição do Livro',
//       nota: 4.5,
//       favorito: true,
//       autor: autorExemplo,
//     );

//     when(() => mockLivroBox.add(livro)).thenAnswer((_) async => 1);

//     await mockLivroBox.add(livro);

//     verify(() => mockLivroBox.add(livro)).called(1);
//   });

//   test('Deve atualizar um livro existente', () async {
//     final livro = Livro(
//       nome: 'Livro Atualizado',
//       descricao: 'Descrição Atualizada',
//       nota: 4.0,
//       favorito: false,
//       autor: autorExemplo,
//     );

//     when(() => mockLivroBox.put(1, livro))
//         .thenAnswer((_) async => Future.value());

//     await mockLivroBox.put(1, livro);

//     verify(() => mockLivroBox.put(1, livro)).called(1);
//   });
// }
