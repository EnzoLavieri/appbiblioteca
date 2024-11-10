import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';

void main() {
  testWidgets('Teste de renderização da tela Dashboard',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);

    expect(find.text('Bem-vindo à Biblioteca'), findsOneWidget);

    expect(find.text('Lista de Livros'), findsOneWidget);

    expect(find.text('Adicionar Livro'), findsOneWidget);

    expect(find.text('Adicionar Autor'), findsOneWidget);
  });
}
