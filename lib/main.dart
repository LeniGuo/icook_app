import 'package:flutter/material.dart';
import 'frame/user/user.dart';
import 'frame/recipe/recipe.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void _navigateToUserScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
          backgroundColor: Colors.blue
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('USER'),
          onPressed: () => _navigateToUserScreen(context),
        ),
      ),
    );
  }
}