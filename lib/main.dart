import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;  // Для виведення повідомлення про помилку

  @override
  void dispose() {
    _controller.dispose();  // Звільняємо ресурс, коли віджет видаляється
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      final String input = _controller.text;

      if (int.tryParse(input) != null) {
        _counter += int.parse(input);
        _errorMessage = null;  // Очищаємо повідомлення про помилку
      } else if (input == 'Avada Kedavra') {
        _counter = 0;
        _errorMessage = null;
      } else {
        _errorMessage = 'Введіть число або "Avada Kedavra"';
      }

      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Інтерактивне поле введення'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Інкремент: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Введіть число або "Avada Kedavra"',
                  errorText: _errorMessage,  // Виводимо повідомлення про помилку
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Оновити інкремент'),
            ),
          ],
        ),
      ),
    );
  }
}
