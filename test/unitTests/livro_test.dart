// import 'package:flutter_application_1/models/autores/autor.dart';
// import 'package:flutter_application_1/models/livros/livro.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('Livro Unit Tests', () {
//     test('Deve criar um livro com os atributos corretos', () {
//       final autor = Autor(nome: 'Autor Exemplo', nacionalidade: 'Brasileiro');
//       final livro = Livro(
//         nome: 'Livro Teste',
//         descricao: 'Descrição do Livro',
//         nota: 4.5,
//         favorito: true,
//         autor: autor,
//       );

//       expect(livro.nome, 'Livro Teste');
//       expect(livro.descricao, 'Descrição do Livro');
//       expect(livro.nota, 4.5);
//       expect(livro.favorito, true);
//       expect(livro.autor, autor);
//     });

//     test('Deve atualizar os atributos do livro', () {
//       final autorInicial =
//           Autor(nome: 'Autor Inicial', nacionalidade: 'Brasileiro');
//       final novoAutor = Autor(nome: 'Novo Autor', nacionalidade: 'Português');
//       final livro = Livro(
//         nome: 'Livro Antigo',
//         descricao: 'Descrição Antiga',
//         nota: 3.0,
//         favorito: false,
//         autor: autorInicial,
//       );

//       livro.nome = 'Livro Atualizado';
//       livro.descricao = 'Descrição Atualizada';
//       livro.nota = 4.0;
//       livro.favorito = true;
//       livro.autor = novoAutor;

//       expect(livro.nome, 'Livro Atualizado');
//       expect(livro.descricao, 'Descrição Atualizada');
//       expect(livro.nota, 4.0);
//       expect(livro.favorito, true);
//       expect(livro.autor, novoAutor);
//     });
//   });
// }
