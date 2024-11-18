import 'package:flutter/material.dart';
import 'package:fluttepr3/RecipeDetailScreen.dart';
import 'package:fluttepr3/screens/favorite_screen.dart'; // Экран избранного
import 'package:fluttepr3/screens/profile_screen.dart'; // Экран профиля
import 'package:fluttepr3/screens/recipe_screen.dart'; // Экран рецептов
import 'dart:ui'; // Для использования BackdropFilter

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> recipes = [
    {'title': 'Паста Карбонара', 'image': 'lib/assets/images/pasta-karbonara-s-bekonom-v-slivkax.jpg', 'description': 'Вкусная паста с беконом и соусом.'},
    {'title': 'Салат Цезарь', 'image': 'lib/assets/images/tsezr.jpg', 'description': 'Классический салат с курицей и сухариками.'},
    {'title': 'Борщ', 'image': 'lib/assets/images/R.jpg', 'description': 'Традиционный суп с красной свеклой.'},
    {'title': 'Пицца Маргарита', 'image': 'lib/assets/images/pizz.jpg', 'description': 'Классическая пицца с томатами и сыром.'},
    {'title': 'Суши', 'image': 'lib/assets/images/sushi_sake.jpg', 'description': 'Роллы с рыбой и овощами.'},
    {'title': 'Торт Наполеон', 'image': 'lib/assets/images/npoleon.png', 'description': 'Классический слоёный торт.'},
    {'title': 'Жареная курица', 'image': 'lib/assets/images/chiken.png', 'description': 'Хрустящая жареная курица.'},
    {'title': 'Блины', 'image': 'lib/assets/images/blini.jpg', 'description': 'Тонкие блины с начинкой.'},
    {'title': 'Греческий салат', 'image': 'lib/assets/images/grecheskii-salat-optimized.jpg', 'description': 'Салат с огурцами, помидорами и фетой.'},
    {'title': 'Шашлык', 'image': 'lib/assets/images/shlik.jpg', 'description': 'Мясо, запеченное на углях.'},
    {'title': 'Лазанья', 'image': 'lib/assets/images/лазанья.jpg', 'description': 'Итальянское блюдо с пастой и мясом.'},
    {'title': 'Омлет', 'image': 'lib/assets/images/omlet.jpg', 'description': 'Классический омлет с овощами.'},
    {'title': 'Ризотто', 'image': 'lib/assets/images/rizzotto.jpg', 'description': 'Итальянский рис с грибами.'},
    {'title': 'Суп с фрикадельками', 'image': 'lib/assets/images/86.jpg', 'description': 'Суп с мясными фрикадельками.'},
    {'title': 'Печенье', 'image': 'lib/assets/images/334.png', 'description': 'Домашнее печенье с шоколадом.'},
    {'title': 'Чизкейк', 'image': 'lib/assets/images/cheez.jpg', 'description': 'Нежный чизкейк с ягодами.'},
  ];

  List<Map<String, dynamic>> favoriteRecipes = []; // Избранное
  List<Map<String, dynamic>> userRecipes = []; // Рецепты, созданные пользователем

  // Добавление нового рецепта
  void addRecipe(Map<String, dynamic> recipe) {
    setState(() {
      userRecipes.add(recipe);
    });
  }

  // Удаление или добавление в избранное
  void toggleFavorite(Map<String, dynamic> recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Преобразование favoriteRecipes в нужный формат
    List<Map<String, String>> favoriteRecipesString = favoriteRecipes
        .map((recipe) => recipe.cast<String, String>())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Рецепты'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Фоновое изображение с размытие
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/xYKQ3cx0UDlKKdIbofFDPg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0), // Размытие фона
              child: Container(
                color: Colors.black.withOpacity(0.5), // Добавляем затемнение
              ),
            ),
          ),
          Column(
            children: [
              // Шапка с панелями
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Панель избранного
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteScreen(favoriteRecipes: favoriteRecipesString),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.bookmark, color: Colors.blue, size: 30),
                      ),
                    ),
                    SizedBox(width: 40),
                    // Панель списка рецептов
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeScreen(onAddRecipe: addRecipe),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.list, color: Colors.blue, size: 30),
                      ),
                    ),
                    SizedBox(width: 40),
                    // Панель профиля
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(userRecipes: userRecipes),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.blue, size: 30),
                      ),
                    ),
                  ],
                ),
              ),

              // Добавление GridView для отображения рецептов в ячейках
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Устанавливаем 3 ячейки в строке
                    crossAxisSpacing: 16, // Расстояние между ячейками по горизонтали
                    mainAxisSpacing: 16, // Расстояние между ячейками по вертикали
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: recipe['image']!.contains('lib/assets/images')
                                    ? Image.asset(
                                        recipe['image']!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ) // Для локального изображения
                                    : Image.network(
                                        recipe['image']!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ), // Для сетевого изображения
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: Text(
                                  recipe['title']!,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center, // Выравнивание текста по центру
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}













