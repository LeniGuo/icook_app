import 'package:flutter/material.dart';
import 'sidebar.dart';

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
      home: ChatScreen(),
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

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _currentConversation.add(text);
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatMessage(
          text: "Please select a dish type:",
          isUser: false,
          isSystem: true,
          tags: ['Chinese Food', 'Western Food', 'Dessert'],
          onTagTap: _handleTagSelection,
        ));
      });
    });
  }

  void _handleTagSelection(String tag) {
    setState(() {
      _currentConversation.add(tag);
      _messages.add(ChatMessage(text: tag, isUser: true));
      _messages.add(ChatMessage(
        text: "Here's a recipe preview of the $tag you've chosen.",
        isUser: false,
      ));
    });
  }

  void _startNewConversation() {
    setState(() {
      _history.add(List.from(_currentConversation)); // 将当前会话保存到历史
      _currentConversation.clear();
      _messages.clear();
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
                decoration: InputDecoration.collapsed(hintText: "Message..."),
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                // 添加相机功能处理代码
              },
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
  final String text;
  final bool isUser;
  final bool isSystem;
  final List<String>? tags;
  final Function(String)? onTagTap;

  ChatMessage({required this.text, required this.isUser, this.isSystem = false, this.tags, this.onTagTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isUser ? EdgeInsets.only(top: 10.0, bottom: 10.0, left: 80.0) : EdgeInsets.only(top: 10.0, bottom: 10.0, right: 80.0),
      child: isSystem && tags != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tags!.map((tag) {
          return GestureDetector(
            onTap: () {
              // 处理标签点击
              if (onTagTap != null) {
                onTagTap!(tag);
              }
            },
            child: Chip(
              label: Text(tag),
            ),
          );
        }).toList(),
      )
          : Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Text(
              text,
              style: TextStyle(color: isUser ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
