import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final List<String> _imagePaths = [
    'assets/images/tomato_eggs.jpg',
    'assets/images/mapotofu.jpg',
    'assets/images/fish_salad.jpg',
    // ... 添加更多图片路径
  ];
  int _currentIndex = 0;

  void _handleDislike() {
    // 处理不喜欢逻辑，这里只是打印信息
    setState(() {
      _currentIndex = (_currentIndex + 1) % _imagePaths.length;
    });
    print('Disliked');
  }

  void _handleLike() {
    // 跳转到下一张图片
    setState(() {
      _currentIndex = (_currentIndex + 1) % _imagePaths.length;
    });
    print('Liked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Swiper'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildImageCard(),
            Positioned(
              left: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: _handleDislike,
                backgroundColor: Colors.red,
                child: const Icon(Icons.thumb_down),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: _handleLike,
                backgroundColor: Colors.green,
                child: const Icon(Icons.thumb_up),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(_imagePaths[_currentIndex]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}