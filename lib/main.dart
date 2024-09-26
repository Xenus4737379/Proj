import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;  // Лічильник
  final TextEditingController _controller = TextEditingController();  // Контролер для текстового поля

  void _incrementCounter() {
    setState(() {
      String input = _controller.text;  // Отримуємо текст з поля введення

      // Якщо введений текст є числом, додаємо його до лічильника
      if (int.tryParse(input) != null) {
        _counter += int.parse(input);
      }

      // Якщо введено "Avada Kedavra", скидаємо лічильник до 0
      if (input == "Avada Kedavra") {
        _counter = 0;
      }

      // Очищаємо поле після обробки
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Інтерактивне поле введення'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Інкремент: $_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,  // Прив'язуємо контролер
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введіть число або "Avada Kedavra"',
                ),
                keyboardType: TextInputType.text,  // Тип введення
              ),
            ),
            ElevatedButton(
              onPressed: _incrementCounter,  // Викликає функцію інкременту при натисканні
              child: Text('Оновити інкремент'),
            ),
          ],
        ),
      ),
    );
  }
}
