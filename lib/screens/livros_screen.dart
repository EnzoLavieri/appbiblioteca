import 'package:flutter/material.dart';
import '../models/livros/livro.dart';
import '../services/api_service.dart';
import 'formulario_livro_screen.dart';

class LivrosScreen extends StatefulWidget {
  const LivrosScreen({super.key});

  @override
  _LivrosScreenState createState() => _LivrosScreenState();
}

class _LivrosScreenState extends State<LivrosScreen> {
  late Future<List<Livro>> livros;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    livros = apiService.fetchLivros();
  }

  void _toggleFavorito(Livro livro) async {
    setState(() {
      livro.isFavorito = !livro.isFavorito;
    });
    // Opcional: Atualize o livro no backend
    await apiService.updateLivro(livro);
  }

  void _deleteLivro(String livroId) async {
    try {
      await apiService.deleteLivro(livroId);
      setState(() {
        livros = apiService.fetchLivros();
      });
    } catch (error) {
      print('Erro ao excluir livro: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Livros'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Todos'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: FutureBuilder<List<Livro>>(
          future: livros,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum livro encontrado.'));
            }

            final allLivros = snapshot.data!;
            final favoritos =
                allLivros.where((livro) => livro.isFavorito).toList();

            return TabBarView(
              children: [
                _buildListView(allLivros),
                _buildListView(favoritos),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Livro> livros) {
    return ListView.builder(
      itemCount: livros.length,
      itemBuilder: (context, index) {
        final livro = livros[index];
        return Card(
          child: ListTile(
            title: Text(livro.titulo),
            subtitle: Text(livro.descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    livro.isFavorito ? Icons.favorite : Icons.favorite_border,
                    color: livro.isFavorito ? Colors.red : null,
                  ),
                  onPressed: () => _toggleFavorito(livro),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormularioLivroScreen(livro: livro),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteLivro(livro.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
