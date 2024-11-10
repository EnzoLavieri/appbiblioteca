import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/autores/autor.dart';
import '../services/api_service.dart';

class FormularioAutorScreen extends StatefulWidget {
  final Autor? autor;

  FormularioAutorScreen({this.autor});

  @override
  _FormularioAutorScreenState createState() => _FormularioAutorScreenState();
}

class _FormularioAutorScreenState extends State<FormularioAutorScreen> {
  final _nomeController = TextEditingController();
  final _nacionalidadeController = TextEditingController();
  final _idController = TextEditingController();

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    if (widget.autor != null) {
      _nomeController.text = widget.autor!.nome;
      _nacionalidadeController.text = widget.autor!.nacionalidade;
      _idController.text = widget.autor!.id;
    }
  }

  void _submitForm() {
    final nome = _nomeController.text;
    final nacionalidade = _nacionalidadeController.text;
    final id = _idController.text.isEmpty
        ? Uuid().v4() // Gerando o UUID aqui
        : _idController.text;

    if (nome.isNotEmpty && nacionalidade.isNotEmpty) {
      final autor = Autor(
        id: id,
        nome: nome,
        nacionalidade: nacionalidade,
      );
      if (widget.autor == null) {
        apiService.addAutor(autor);
      } else {
        apiService.updateAutor(autor);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.autor == null ? 'Adicionar Autor' : 'Editar Autor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.autor != null) ...[
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                enabled: false,
              ),
            ],
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _nacionalidadeController,
              decoration: InputDecoration(labelText: 'Nacionalidade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(widget.autor == null
                  ? 'Adicionar Autor'
                  : 'Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
