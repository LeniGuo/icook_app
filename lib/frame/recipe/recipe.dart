import 'package:flutter/material.dart';
import 'package:icook/frame/user/user.dart';
class RecipeDetailPage extends StatelessWidget {
final String recipeName;

RecipeDetailPage({required this.recipeName});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('菜谱详情'),
    ),
    body: Center(
      child: Text('菜谱名称: $recipeName'),
    ),
  );
}
}