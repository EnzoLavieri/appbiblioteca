import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../autores/autor.dart';
import 'livro.dart';

class LivroForm extends StatefulWidget {
  const LivroForm({super.key});

  @override
  _LivroFormState createState() => _LivroFormState();
}

class _LivroFormState extends State<LivroForm> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  double _nota = 1;
  Autor? _autorSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Novo Livro')),
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
              hint: const Text('Selecione o Autor'),
              value: _autorSelecionado,
              onChanged: (Autor? novoAutor) {
                setState(() {
                  _autorSelecionado = novoAutor;
                });
              },
              items: Hive.box<Autor>('autores')
                  .values
                  .map((autor) => DropdownMenuItem<Autor>(
                        value: autor,
                        child: Text(autor.nome),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_autorSelecionado == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selecione um autor!')),
                  );
                  return;
                }

                final livro = Livro(
                  nome: _nomeController.text,
                  descricao: _descricaoController.text,
                  nota: _nota,
                  autor: _autorSelecionado,
                );

                Hive.box<Livro>('livros').add(livro);

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
