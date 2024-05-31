import 'package:flutter/material.dart';
import 'package:icook/frame/recipe/recipe.dart';
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonalHomePage(),
    );
  }
}

class PersonalHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView( // 移除了Center，因为ListView本身可以滚动，不需要再居中
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildUserInfo(),
          const SizedBox(height: 16.0),
          _buildRecipes(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    // 假设用户名和邮箱是已知的字符串，实际情况下应动态获取
    String userName = 'Peter';
    String userEmail = 'user@example.com';
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
            radius: 40.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            userName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            userEmail,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipes() {
    // 假设你有一些菜谱的数据
    List<Map<String, String>> recipes = [
      {'name': 'Mapo Tofu', 'imagePath': 'assets/images/mapotofu.jpg'},
      {'name': 'Shrimp', 'imagePath': 'assets/images/shrimp.jpg'},
      // ...更多菜谱
    ];

    return Column(
      children: recipes.map((recipe) {
        return RecipeCard(recipe: recipe);
      }).toList(),
    );
  }
}

// 创建一个RecipeCard小部件来展示每个菜谱
class RecipeCard extends StatelessWidget {
  final Map<String, String> recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 跳转逻辑，例如使用Navigator.push
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailPage(recipeName: recipe['name']!)),
        );
      },
      child: Container(
        // 菜谱卡片的布局和样式
        child: Column(
          children: [
            Image.asset(
              recipe['imagePath']!,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              recipe['name']!,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
