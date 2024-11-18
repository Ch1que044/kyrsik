import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddRecipe; // Функция для добавления рецепта

  RecipeScreen({required this.onAddRecipe}); // Конструктор

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  void _addRecipe() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        String? imageUrl;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Добавить рецепт',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Название рецепта',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Описание рецепта',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Ссылка на изображение (URL)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    imageUrl = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  // Вызываем переданную функцию для сохранения рецепта
                  widget.onAddRecipe({
                    'title': title,
                    'description': description,
                    'image': imageUrl ?? '',
                  });

                  Navigator.pop(context); // Закрываем диалог
                }
              },
              child: Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Возвращаемся назад
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
                  ),
                  Text(
                    'Ваши рецепты',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  IconButton(
                    onPressed: _addRecipe,
                    icon: Icon(Icons.add_circle, color: Colors.grey.shade600, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}









