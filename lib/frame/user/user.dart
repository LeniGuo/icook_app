import 'package:flutter/material.dart';
import 'package:icook/frame/recipe/recipe.dart';
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Container(
        color: Color.fromARGB(223, 168, 215, 246), // 设置容器的背景颜色为绿色
        child: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}