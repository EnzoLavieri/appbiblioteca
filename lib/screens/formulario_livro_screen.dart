import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/autores/autor.dart';
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
  int? _selectedAutorId;
  List<Autor> _autores = [];

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadAutores();
  }

  Future<void> _loadAutores() async {
    try {
      final autores = await apiService.fetchAutores();
      setState(() {
        _autores = autores;
      });
    } catch (error) {
      print("Erro ao carregar autores: $error");
    }
  }

  void _submitForm() {
    final titulo = _tituloController.text;
    final descricao = _descricaoController.text;
    final nota = double.tryParse(_notaController.text) ?? 0.0;

    if (titulo.isNotEmpty && descricao.isNotEmpty && _selectedAutorId != null) {
      final livro = Livro(
        id: Uuid().v4(),
        titulo: titulo,
        descricao: descricao,
        nota: nota,
        autorId: _selectedAutorId!,
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
            DropdownButton<int>(
              hint: Text('Selecione o Autor'),
              value: _selectedAutorId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedAutorId = newValue;
                });
              },
              items: _autores.map((autor) {
                return DropdownMenuItem<int>(
                  value: int.tryParse(autor.id) ?? 0,
                  child: Text(autor.nome),
                );
              }).toList(),
            ),
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
