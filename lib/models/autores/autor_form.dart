import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'autor.dart';

class AutorForm extends StatefulWidget {
  const AutorForm({super.key});

  @override
  _AutorFormState createState() => _AutorFormState();
}

class _AutorFormState extends State<AutorForm> {
  final _nomeController = TextEditingController();
  final _nacionalidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Novo Autor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Autor'),
            ),
            TextField(
              controller: _nacionalidadeController,
              decoration: const InputDecoration(labelText: 'Nacionalidade'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final autor = Autor(
                  nome: _nomeController.text,
                  nacionalidade: _nacionalidadeController.text,
                );

                Hive.box<Autor>('autores').add(autor);

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
