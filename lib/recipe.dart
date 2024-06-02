import 'package:flutter/material.dart';
import 'package:icook/user.dart';
class RecipeDetailPage extends StatefulWidget {
  final String recipeName;
  RecipeDetailPage({required this.recipeName});
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final List<String> _ingredients = ['Tuna', 'Cherry Tomato', 'Cucumber', 'Red Pepper', 'Red Onion', 'Egg', 'Red Wine Vinegar', 'Pepper', 'Olive Oil'];
  late final List<bool> _ingredientsChecked = List.generate(_ingredients.length, (index) => false);

  // 具体的步骤列表
  final List<String> _steps = [
    'Cook the eggs in water',
    'Tear the lettuce into pieces, halve the cherry tomatoes',
    'Slice the cucumber using a rolling blade, shred the red bell pepper',
    'Shred the purple onion, and divide the eggs into four equal parts',
    'Drain the tuna',
    'Sprinkle with black pepper, red wine vinegar, and a little olive oil',
    'Mix well and enjoy!'

    // ... 你可以继续添加其他步骤
  ];
  late final List<bool> _stepsChecked = List.generate(_steps.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Detail'),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 图片（替换为实际图片链接）
            Image.asset(
              'assets/images/fish_salad.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            // 菜名
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.recipeName,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            // 食材列表
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'INGREDIENTS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(
                  _ingredients.length,
                      (index) => CheckboxListTile(
                    title: Text(_ingredients[index]),
                    value: _ingredientsChecked[index],
                    onChanged: (value) {
                      setState(() {
                        _ingredientsChecked[index] = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),
            ),
            // 步骤列表
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'STEP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: List.generate(
                  _steps.length,
                      (index) => CheckboxListTile(
                    title: Text(_steps[index]),
                    value: _stepsChecked[index],
                    onChanged: (value) {
                      setState(() {
                        _stepsChecked[index] = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}