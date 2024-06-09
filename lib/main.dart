import 'package:flutter/material.dart';
import 'package:icook/register.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'sidebar.dart';
import 'share.dart';
import 'login.dart';
import 'recipe.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCook App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => ChatScreen(),
        '/share': (context) => SwipePage(), // Define the route for share.dart
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen()
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final List<List<String>> _history = []; // 存储历史消息
  final List<String> _currentConversation = []; // 当前会话消息
  final TextEditingController _textController = TextEditingController();
  final Set<String> _selectedTags = Set<String>(); // 存储选中的标签
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _currentConversation.add(text);
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatMessage(
          text: "please select tags",
          isUser: false,
          isSystem: true,
          tags: ['tomato', 'egg'],
          onTagTap: _handleTagSelection,
          onConfirm: _confirmSelection,
          selectedTags: _selectedTags,
        ));
      });
    });
  }

  void _handleTagSelection(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _confirmSelection() {
    setState(() {
      if (_selectedTags.isNotEmpty) {
        String selectedTagsString = _selectedTags.join(", ");
        _currentConversation.add(selectedTagsString);
        _messages.add(ChatMessage(
          text: 'Preview of Recipe: Tomato and Egg Stir Fry\nIngredients: 2 large eggs\n1 medium tomato\n2 tablespoons vegetable oil\n1/2 teaspoon salt\n1/4 teaspoon sugar\n1/4 teaspoon soy sauce (optional)\n1/4 teaspoon white pepper (optional)\n',
          isUser: false,
        ));
        _selectedTags.clear();
      }
    });
  }

  void _startNewConversation() {
    setState(() {
      _history.add(List.from(_currentConversation)); // 将当前会话保存到历史
      _currentConversation.clear();
      _messages.clear();
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path); // 存储选定的图像
        _messages.add(ChatMessage(
          image: _image, // 添加图片对象
          isUser: true,
        ));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.share), // Icon for sharing
            onPressed: () {
              Navigator.pushNamed(context, '/share'); // Navigate to share.dart
            },
          ),
        ],
      ),
      drawer: SideBar(
        history: _history,
        currentConversation: _currentConversation,
        startNewConversation: _startNewConversation,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: "发送消息..."),
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _pickImage,
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final bool isUser;
  final bool isSystem;
  final List<String>? tags;
  final Function(String)? onTagTap;
  final VoidCallback? onConfirm;
  final XFile? image; // 使用XFile来存储图像文件
  final Set<String>? selectedTags; // 添加选中的标签参数

  ChatMessage({this.text, required this.isUser, this.isSystem = false, this.tags, this.onTagTap, this.onConfirm, this.image, this.selectedTags});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isUser ? EdgeInsets.only(top: 10.0, bottom: 10.0, left: 80.0) : EdgeInsets.only(top: 10.0, bottom: 10.0, right: 80.0),
      child: isSystem && tags != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6.0,
            children: tags!.map((tag) {
              return GestureDetector(
                onTap: () {
                  if (onTagTap != null) {
                    onTagTap!(tag);
                  }
                },
                child: Chip(
                  label: Text(tag),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 12.0), // 增加间隔
          ElevatedButton(
            onPressed: onConfirm,
            child: Text('Confirm'),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          image != null ? Image.file(File(image!.path), width: 200.0, height: 200.0) : Container(), // 如果image不为空，则显示图片
          text != null ? Container(
            decoration: BoxDecoration(
              color: isUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            margin: EdgeInsets.only(left: isUser ? 8.0 : 0.0, right: isUser ? 0.0 : 8.0),
            child: Text(
              text!,
              style: TextStyle(color: isUser ? Colors.white : Colors.black),
            ),
          ) : Container(), // 如果text不为空，则显示文本
        ],
      ),
    );
  }
}
