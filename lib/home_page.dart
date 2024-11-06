import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/autores/autor_form.dart';
import 'models/livros/livro.dart';
import 'models/livros/livro_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Biblioteca Pessoal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Livros'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LivrosTab(favoritos: false),
            LivrosTab(favoritos: true),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LivroForm()),
                );
              },
              heroTag: 'addBook',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AutorForm()),
                );
              },
              heroTag: 'addAuthor',
              child: const Icon(Icons.person_add),
            ),
          ],
        ),
      ),
    );
  }
}

class LivrosTab extends StatelessWidget {
  final bool favoritos;

  const LivrosTab({super.key, required this.favoritos});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Livro>('livros').listenable(),
      builder: (context, Box<Livro> box, _) {
        List<Livro> livros = box.values
            .where((livro) => favoritos ? livro.favorito : true)
            .toList();

        if (livros.isEmpty) {
          return const Center(child: Text('Nenhum livro encontrado.'));
        }

        return ListView.builder(
          itemCount: livros.length,
          itemBuilder: (context, index) {
            Livro livro = livros[index];
            return ListTile(
              title: Text('Título:${livro.nome}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descrição: ${livro.descricao}'),
                  Text(
                      'Autor: ${livro.autor?.nome} (${livro.autor?.nacionalidade})'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      livro.favorito ? Icons.favorite : Icons.favorite_border,
                      color: livro.favorito ? Colors.red : null,
                    ),
                    onPressed: () {
                      livro.favorito = !livro.favorito;
                      livro.save();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LivroForm(livro: livro),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
