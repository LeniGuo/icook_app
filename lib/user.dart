import 'package:flutter/material.dart';
import 'package:icook/recipe.dart';
import 'package:icook/upload.dart';
import 'package:icook/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserScreen extends StatefulWidget {
  @override
  PersonalHomePage createState()=>PersonalHomePage();
}

class PersonalHomePage extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER'),
        actions: <Widget>[ // 在这里添加actions属性来放置按钮
          IconButton(
            icon: Icon(Icons.add), // 使用加号图标
            tooltip: 'Upload Your Recipe',
            onPressed: () {
              // 导航到上传菜谱页面
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadRecipeScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit User Info',
            onPressed: () {
              // 导航到编辑用户信息页面
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              _logout();
            },
          ),
        ],
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
  late String _username;
  late String _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // 读取用户名和邮箱
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
      _email = prefs.getString('email') ?? 'guest@example.com';
    });
  }
  Widget _buildUserInfo() {
    // 假设用户名和邮箱是已知的字符串，实际情况下应动态获取
    String userName = '$_username';
    String userEmail = '$_email';
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
      {'name': 'Spanish Tuna Salad', 'imagePath': 'assets/images/fish_salad.jpg'},
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
  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // 清除用户名和邮箱
    await prefs.remove('username');
    await prefs.remove('email');

    // 通知用户已退出登录，可能需要重定向到登录页面
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout Successful')));
    Navigator.pushReplacementNamed(context, '/login'); // 返回到第一个路由，通常是登录或主页
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
          //MaterialPageRoute(builder: (context) => RecipeDetailPage()),
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
