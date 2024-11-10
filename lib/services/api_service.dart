import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/autores/autor.dart';
import '../models/livros/livro.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<void> addAutor(Autor autor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/autores'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(autor.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add autor');
    }
  }

  Future<List<Autor>> fetchAutores() async {
    final response = await http.get(Uri.parse('$baseUrl/autores'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Autor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load autores');
    }
  }

  Future<void> updateAutor(Autor autor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${autor.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(autor.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar autor');
    }
  }

  Future<List<Livro>> fetchLivros() async {
    final response = await http.get(Uri.parse('$baseUrl/livros'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Livro.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load livros');
    }
  }

  Future<void> addLivro(Livro livro) async {
    final response = await http.post(
      Uri.parse('$baseUrl/livros'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(livro.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add livro');
    }
  }

  Future<void> deleteLivro(String livroId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/livros/$livroId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete livro');
    }
  }

  Future<void> updateLivro(Livro livro) async {
    final response = await http.put(
      Uri.parse('$baseUrl/livros/${livro.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(livro.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar livro');
    }
  }
}
