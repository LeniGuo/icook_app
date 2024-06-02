import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SwipePage(),
    );
  }
}

class SwipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share'),
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
                onPressed: () {
                  print('Disliked');
                },
                child: Icon(Icons.thumb_down),
                backgroundColor: Colors.red,
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  print('Liked');
                },
                child: Icon(Icons.thumb_up),
                backgroundColor: Colors.green,
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
            image: AssetImage('assets/share.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
