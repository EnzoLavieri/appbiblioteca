import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/livros/livro.dart';
import 'home_page.dart';
import 'models/autores/autor.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LivroAdapter());
  Hive.registerAdapter(AutorAdapter());
  await Hive.openBox<Livro>('livros');
  await Hive.openBox<Autor>('autores');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Pessoal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
