import 'package:flutter/material.dart';
import 'home_screen.dart'; // Импортируем экран HomeScreen, на который нужно вернуться
import 'dart:ui'; // Для использования BackdropFilter

class ProfileScreen extends StatefulWidget {
  final List<Map<String, dynamic>> userRecipes; // Список рецептов пользователя

  ProfileScreen({required this.userRecipes});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  String _nickname = 'User123'; // Начальный никнейм
  String _bio = 'Информация о себе'; // Начальная информация

  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nicknameController.text = _nickname;
    _bioController.text = _bio;
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Расчет уровня пользователя на основе количества рецептов
  int get _level => widget.userRecipes.length + 1;

  // Эффект уровня
  Color _getLevelColor() {
    if (_level < 5) {
      return Colors.green;
    } else if (_level < 10) {
      return Colors.blue;
    } else {
      return Colors.purple;
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveInfo() {
    setState(() {
      _nickname = _nicknameController.text;
      _bio = _bioController.text;
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Фоновое изображение без размытия
            Positioned.fill(
              child: Image.asset(
                'lib/assets/images/Tipos-de-pan.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Размытие фона с помощью BackdropFilter
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0), // Размытие 60%
                child: Container(
                  color: Colors.black.withOpacity(0.4), // Применяем затемнение для улучшения контраста
                ),
              ),
            ),
            // Основной контент
            Column(
              children: [
                // Шапка страницы с кнопкой назад
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.6),
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()), // Переход на HomeScreen
                          );
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Профиль',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Аватарка и уровень
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Аватарка
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade300,
                      child: Text(
                        _nickname[0].toUpperCase(),
                        style: TextStyle(fontSize: 40, color: Colors.grey.shade800),
                      ),
                    ),

                    // Кружок уровня
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Задний эффект
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getLevelColor().withOpacity(0.3),
                            ),
                          ),
                          // Передний круг с уровнем
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  _getLevelColor().withOpacity(0.8),
                                  _getLevelColor(),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$_level',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Никнейм
                _isEditing
                    ? TextField(
                        controller: _nicknameController,
                        decoration: InputDecoration(
                          labelText: 'Никнейм',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                      )
                    : Text(
                        _nickname,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                SizedBox(height: 20),

                // Информация о себе
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _bioController,
                    readOnly: !_isEditing,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Информация о себе',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Кнопка редактирования
                ElevatedButton(
                  onPressed: _isEditing ? _saveInfo : _toggleEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Сохранить' : 'Редактировать',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),

                // Список рецептов
                Expanded(
                  child: widget.userRecipes.isEmpty
                      ? Center(
                          child: Text(
                            'Вы еще не добавили рецептов.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: widget.userRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = widget.userRecipes[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: recipe['image'] != null && recipe['image'].isNotEmpty
                                      ? Image.network(recipe['image'],
                                          width: 50, height: 50, fit: BoxFit.cover)
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey.shade200,
                                          child: Icon(Icons.image, color: Colors.grey.shade400),
                                        ),
                                ),
                                title: Text(
                                  recipe['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  recipe['description'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



















