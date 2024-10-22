import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ігрові новини',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/Логін': (context) => LoginPage(),
        '/Регістрація': (context) => RegisterPage(),
        '/Профіль': (context) => ProfilePage(
              username: savedUsername,
              email: savedEmail,
              password: savedPassword,
            ),
        '/Головна сторінка': (context) => const HomePage(),
      },
    );
  }
}

// Створимо змінні для збереження даних користувача
String savedUsername = '';
String savedEmail = '';
String savedPassword = '';

// Екран Логіну
class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вхід')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Ім'я"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Вхід',
              onPressed: () {
                if (usernameController.text == savedUsername &&
                    passwordController.text == savedPassword) {
                  Navigator.pushNamed(context, '/Головна сторінка');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Неправильне ім'я чи пароль, спробуйте ще раз"),
                    ),
                  );
                }
              },
            ),
            CustomButton(
              text: 'Регістрація',
              onPressed: () {
                Navigator.pushNamed(context, '/Регістрація');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Екран Реєстрації
class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регістрація')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Ім'я"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Емейл'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Регістрація',
              onPressed: () {
                savedUsername = usernameController.text;
                savedEmail = emailController.text;
                savedPassword = passwordController.text;

                Navigator.pushNamed(context, '/Логін');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Екран Профілю
class ProfilePage extends StatelessWidget {
  final String username;
  final String email;
  final String password;

  const ProfilePage({
    required this.username,
    required this.email,
    required this.password,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'З ПОВЕРНЕННЯМ, $username!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Логін: $username',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Емейл: $email',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Пароль: $password',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Редагувати',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (context) => EditProfilePage(
                        username: username,
                        email: email,
                        password: password,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Екран редагування профілю
class EditProfilePage extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  EditProfilePage({
    required String username,
    required String email,
    required String password,
    super.key,
  })  : usernameController = TextEditingController(text: username),
        emailController = TextEditingController(text: email),
        passwordController = TextEditingController(text: password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редагування профілю')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Ім'я"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Емейл'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Зберегти',
              onPressed: () {
                // Оновлення даних у локальному сховищі
                savedUsername = usernameController.text;
                savedEmail = emailController.text;
                savedPassword = passwordController.text;

                // Повертаємося назад до профілю
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Головна Сторінка
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ігрові новини')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Розділ 1
            const Text(
              'Довгоочікувана Red Dead Redemption нарешті буде на компютерах.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Культова гра Red Dead Redemption та її доповнення у стилі зомбі-горрор, Undead Nightmare, будуть доступні на ПК з 29 жовтня 2024 року.\n'
              'Про це Rockstar повідомила у своєму пресрелізі. Версія для ПК отримає кілька покращень, розроблених для використання переваг сучасного обладнання.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Розділ 2
            const Text(
              'Ремейк Silent Hill 2 "злили" в інтернет – за кілька днів до офіційного релізу.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Компанія Konami відкрила ранній доступ до довгоочікуваного ремейка Silent Hill 2 для всіх, хто попередньо замовив розширене видання гри на ПК і PS5.\n'
              'Виявилося, що у Silent Hill 2 Remake не було ніякого захисту від злому, тому делюкс-версія, що дає ранній доступ до гри, "витекла" на торенти прямо в день виходу. І за два дні до повноцінного релізу для всіх, хто вибрав стандартне видання.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Розділ 3
            const Text(
              'Ремастер Until Dawn стартував гірше, ніж скандальний Concord',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ремастер Until Dawn стартував на ринку з труднощами та викликав змішану реакцію. Статистика показує, що запуск гри від студії Ballistic Moon значно поступається іншим релізам, включно з багатостраждальним шутером Concord.\n'
              'Старт гри на 28,6% слабший, ніж у Concord, і однією з головних причин гравці називають занадто високу ціну.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Додаємо кнопку для переходу до профілю
            Center(
              child: CustomButton(
                text: 'До профілю',
                onPressed: () {
                  Navigator.pushNamed(context, '/Профіль');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Перевикористовуваний віджет Кнопки
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
