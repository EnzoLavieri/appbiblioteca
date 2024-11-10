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

  @override
  void initState() {
    super.initState();
    livros = ApiService().fetchLivros();
  }

  // Função para excluir o livro
  void _deleteLivro(String livroId) async {
    try {
      await ApiService().deleteLivro(livroId);
      setState(() {
        livros =
            ApiService().fetchLivros(); // Recarrega a lista após a exclusão
      });
    } catch (error) {
      print('Erro ao excluir livro: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Livros')),
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

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final livro = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(livro.titulo),
                  subtitle: Text(livro.descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FormularioLivroScreen(livro: livro),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteLivro(livro.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
