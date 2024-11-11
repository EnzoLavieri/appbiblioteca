import 'package:flutter/material.dart';
import '../models/livros/livro.dart';
import '../models/autores/autor.dart';
import '../services/api_service.dart';
import 'formulario_livro_screen.dart';

class LivrosScreen extends StatefulWidget {
  const LivrosScreen({super.key});

  @override
  _LivrosScreenState createState() => _LivrosScreenState();
}

class _LivrosScreenState extends State<LivrosScreen>
    with SingleTickerProviderStateMixin {
  List<Autor> autores = [];
  Future<List<Livro>>? livros;
  final ApiService apiService = ApiService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadLivrosAndAutores();
  }

  void _toggleFavorito(Livro livro) async {
    setState(() {
      livro.isFavorito = !livro.isFavorito;
    });
    // Opcional: Atualize o livro no backend
    await apiService.updateLivro(livro);
  }

  Future<void> _loadLivrosAndAutores() async {
    try {
      final fetchedAutores = await apiService.fetchAutores();
      final fetchedLivros = apiService.fetchLivros();
      setState(() {
        autores = fetchedAutores;
        livros = Future.value(fetchedLivros);
      });
    } catch (error) {
      print("Erro ao carregar livros ou autores: $error");
    }
  }

  String _getAutorNome(int autorId) {
    if (autores.isEmpty) return 'Desconhecido';
    final autor = autores.firstWhere(
      (autor) => int.tryParse(autor.id) == autorId,
      orElse: () => Autor(id: '', nome: 'Desconhecido', nacionalidade: ''),
    );
    return autor.nome;
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

  List<Livro> _filterFavoritos(List<Livro> livros) {
    return livros.where((livro) => livro.isFavorito).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Livros'),
        bottom: TabBar(
          controller: _tabController,
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
          final favoritos = _filterFavoritos(allLivros);

          return TabBarView(
            controller: _tabController,
            children: [
              _buildLivrosList(allLivros),
              _buildLivrosList(favoritos),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLivrosList(List<Livro> livros) {
    return ListView.builder(
      itemCount: livros.length,
      itemBuilder: (context, index) {
        final livro = livros[index];
        final autorNome = _getAutorNome(livro.autorId);

        return Card(
          child: ListTile(
            title: Text(livro.titulo),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(livro.descricao),
                Text('Nota: ${livro.nota}'),
                Text('Autor: $autorNome'),
              ],
            ),
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
