import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttepr3/registration_screen.dart';
// Убедитесь, что этот файл корректно импортирован

void main() {
  testWidgets('Проверка экрана регистрации', (WidgetTester tester) async {
    // Строим наш виджет и запускаем его.
    await tester.pumpWidget(MaterialApp(
      home: RegistrationScreen(),
    ));

    // Проверяем, что заголовок 'Регистрация' присутствует на экране.
    expect(find.text('Регистрация'), findsOneWidget);

    // Проверяем наличие полей для ввода.
    expect(find.byType(TextFormField), findsNWidgets(3)); // Поля: имя, email, пароль.

    // Проверяем кнопку регистрации.
    expect(find.text('Зарегистрироваться'), findsOneWidget);
  });
}

