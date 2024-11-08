import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../autores/autor.dart';
import 'livro.dart';

class LivroForm extends StatefulWidget {
  final Livro? livro;

  const LivroForm({super.key, this.livro});

  @override
  // ignore: library_private_types_in_public_api - E
  _LivroFormState createState() => _LivroFormState();
  //A classe estava apresentando um warn, depois ver como arrumar
}

class _LivroFormState extends State<LivroForm> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  double _nota = 1;
  Autor? _autorSelecionado;

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _nomeController.text = widget.livro!.nome;
      _descricaoController.text = widget.livro!.descricao;
      _nota = widget.livro!.nota;
      _autorSelecionado = widget.livro!.autor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final autoresBox = Hive.box<Autor>('autores');
    List<Autor> autores = autoresBox.values.toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.livro == null ? 'Adicionar Novo Livro' : 'Editar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Livro'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            Slider(
              value: _nota,
              min: 1,
              max: 5,
              divisions: 4,
              label: _nota.toString(),
              onChanged: (value) {
                setState(() {
                  _nota = value;
                });
              },
            ),
            DropdownButton<Autor>(
              hint: const Text("Selecione um autor"),
              value: _autorSelecionado,
              onChanged: (Autor? newValue) {
                setState(() {
                  _autorSelecionado = newValue;
                });
              },
              items: autores.map((Autor autor) {
                return DropdownMenuItem<Autor>(
                  value: autor,
                  child: Text(autor.nome),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (_autorSelecionado != null) {
                  if (widget.livro != null) {
                    widget.livro!.nome = _nomeController.text;
                    widget.livro!.descricao = _descricaoController.text;
                    widget.livro!.nota = _nota;
                    widget.livro!.autor = _autorSelecionado!;
                    widget.livro!.save();
                  } else {
                    final livro = Livro(
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      nota: _nota,
                      autor: _autorSelecionado!,
                    );

                    Hive.box<Livro>('livros').add(livro);
                  }

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selecione um autor')),
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
