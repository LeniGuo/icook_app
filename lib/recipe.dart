import 'package:flutter/material.dart';
class RecipeDetailPage extends StatefulWidget {
  final String recipeName;
  const RecipeDetailPage({super.key, required this.recipeName});
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final List<String> _ingredients = ['2 eggs', '2 tomatoes', '1 tablespoon vegetable oil', '1/2 teaspoon salt', '1/4 teaspoon sugar', '1/2 teaspoon soy sauce(optional)', '1 green onion, chopped'];
  late final List<bool> _ingredientsChecked = List.generate(_ingredients.length, (index) => false);
  bool _isFavorite = false;
  // 具体的步骤列表
  final List<String> _steps = [
    '1. Beat the eggs in a bowl and add a pinch of salt.',
    '2. Heat the oil in a pan over medium heat, and pour in the beaten eggs. stir gently until the eggs are just set but sti1l soft. Remove from the pan and set aside.',
    '3. In the same pan, add a little more oil if necessary, and sauté the chopped green onion until fragrant.',
    '4. Add the diced tomatoes and cook until they start to soften and release juice. Add salt and sugar, and soy sauce if using.',
    '5. Return the scrambled eggs to the pan and mix with the tomatoes.Cook for another minute until everything is well combined.',
    '6.Serve hot with rice or as a side dish.',
    // ... 你可以继续添加其他步骤
  ];
  late final List<bool> _stepsChecked = List.generate(_steps.length, (index) => false);
// 添加一个方法来切换收藏状态
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      // 这里可以添加保存收藏状态的逻辑，比如保存到数据库或本地存储
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Detail'),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        actions: <Widget>[ // 在AppBar的actions中添加收藏按钮
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border, // 根据_isFavorite的值显示不同的图标
              color: _isFavorite ? Colors.red : null, // 当_isFavorite为true时，设置图标颜色为红色
            ),
            onPressed: _toggleFavorite, // 点击时切换收藏状态
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 图片（替换为实际图片链接）
            Image.asset(
              'assets/images/tomato_eggs.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            // 菜名
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.recipeName,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            // 食材列表
            const Padding(
              padding: EdgeInsets.all(10.0),
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
            const Padding(
              padding: EdgeInsets.all(10.0),
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