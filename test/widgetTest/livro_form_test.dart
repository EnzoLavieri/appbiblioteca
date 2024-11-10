import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';

void main() {
  testWidgets('Teste de renderização da tela Dashboard',
      (WidgetTester tester) async {
    // Construir o widget
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));

    // Abrir o Drawer
    await tester.tap(find.byIcon(Icons.menu)); // Ação para abrir o Drawer
    await tester.pumpAndSettle(); // Esperar a animação do Drawer

    // Verificar se o título da AppBar está presente
    expect(find.text('Dashboard'), findsOneWidget);

    // Verificar se o texto "Bem-vindo à Biblioteca" está presente
    expect(find.text('Bem-vindo à Biblioteca'), findsOneWidget);

    // Verificar se o item "Lista de Livros" está presente no Drawer
    expect(find.text('Lista de Livros'), findsOneWidget);

    // Verificar se o item "Adicionar Livro" está presente no Drawer
    expect(find.text('Adicionar Livro'), findsOneWidget);

    // Verificar se o item "Adicionar Autor" está presente no Drawer
    expect(find.text('Adicionar Autor'), findsOneWidget);
  });
}
