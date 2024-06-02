import 'package:flutter/material.dart';

class UploadRecipeScreen extends StatefulWidget {
  @override
  _UploadRecipeScreenState createState() => _UploadRecipeScreenState();
}

class _UploadRecipeScreenState extends State<UploadRecipeScreen> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeIngredientsController = TextEditingController();
  final TextEditingController _recipeStepsController = TextEditingController();
  // ... 可以为其他表单字段添加更多的TextEditingController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Your Own Recipe'),
      ),
      body: SingleChildScrollView( // 使用SingleChildScrollView来处理可能的溢出
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card( // 使用Card widget来包裹表单内容，增加立体感
            elevation: 4.0, // 设置卡片阴影大小
            child: Column(
              mainAxisSize: MainAxisSize.min, // 让卡片大小适应其内容
              children: <Widget>[
                SizedBox(height: 16.0),
                TextField(
                  controller: _recipeNameController,
                  decoration: InputDecoration(
                    labelText: 'Dish Name',
                    border: OutlineInputBorder( // 设置输入框边框
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // 添加间距
                TextField(
                  controller: _recipeIngredientsController,
                  decoration: InputDecoration(
                    labelText: 'Ingredients',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 5, // 如果食材列表很长，允许多行输入
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 16.0), // 添加间距
                TextField(
                  controller: _recipeStepsController,
                  decoration: InputDecoration(
                    labelText: 'Steps',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 5, // 如果食材列表很长，允许多行输入
                  keyboardType: TextInputType.multiline,
                ),
                // ... 添加其他表单控件，如步骤、图片上传等

                SizedBox(height: 24.0), // 添加更多间距
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,// 在这里设置按钮的主色调
                  ),
                  onPressed: () {
                    // 处理按钮点击事件
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ... 其他方法保持不变
}