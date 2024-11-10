import 'package:flutter/material.dart';
import '../models/livros/livro.dart';

class LivroCard extends StatelessWidget {
  final Livro livro;

  const LivroCard({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(livro.titulo),
        subtitle: Text(livro.descricao),
        trailing: Text(livro.nota.toString()),
      ),
    );
  }
}
