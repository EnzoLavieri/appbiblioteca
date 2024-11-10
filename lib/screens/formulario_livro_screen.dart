import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/livros/livro.dart';
import '../services/api_service.dart';

class FormularioLivroScreen extends StatefulWidget {
  @override
  _FormularioLivroScreenState createState() => _FormularioLivroScreenState();
}

class _FormularioLivroScreenState extends State<FormularioLivroScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _notaController = TextEditingController();
  final _autorIdController = TextEditingController();

  final ApiService apiService = ApiService();

  void _submitForm() {
    final titulo = _tituloController.text;
    final descricao = _descricaoController.text;
    final nota = double.tryParse(_notaController.text) ?? 0.0;

    final autorId = int.tryParse(_autorIdController.text) ?? 0;

    if (titulo.isNotEmpty && descricao.isNotEmpty && autorId > 0) {
      final livro = Livro(
        id: Uuid().v4(), // Usando UUID
        titulo: titulo,
        descricao: descricao,
        nota: nota,
        autorId: autorId,
      );
      apiService.addLivro(livro);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título')),
            TextField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição')),
            TextField(
                controller: _notaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Nota')),
            TextField(
                controller: _autorIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Autor ID')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Adicionar Livro'),
            ),
          ],
        ),
      ),
    );
  }
}
