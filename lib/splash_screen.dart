import 'package:flutter/material.dart';
import 'login_screen.dart'; // Импортируем экран логина

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Загрузка',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Тема в оранжевых оттенках
      ),
      home: SplashScreen(), // Указываем, что приложение должно начинаться с экрана SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    
    // Контроллер для плавной анимации роста
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Плавное увеличение
      vsync: this,
    );
    _animation = Tween(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    // Контроллер для вращения анимации
    _rotateController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _rotateController.repeat(); // Создаем бесконечное вращение

    // Запускаем анимацию увеличения
    _controller.forward();

    // После окончания анимации переходим на экран входа (LoginScreen)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Переход на экран логина
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Светлый нейтральный фон
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: RotationTransition(
                turns: _rotateController,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.orange[50], // Мягкий теплый оранжевый оттенок
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.local_dining, // Иконка на тему еды
                      color: Colors.orange,
                      size: 60,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Освобождаем ресурсы
    _rotateController.dispose();
    super.dispose();
  }
}


