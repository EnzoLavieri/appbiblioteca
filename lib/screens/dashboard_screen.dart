import 'package:flutter/material.dart';
import 'livros_screen.dart';
import 'formulario_livro_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(child: Text('Bem-vindo à Biblioteca')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
                title: Text('Lista de Livros'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LivrosScreen()))),
            ListTile(
                title: Text('Adicionar Livro'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => FormularioLivroScreen()))),
          ],
        ),
      ),
    );
  }
}
