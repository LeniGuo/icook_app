import 'package:flutter/material.dart';
import 'package:icook/user.dart';

class SideBar extends StatelessWidget {
  final List<List<String>> history;
  final List<String> currentConversation;
  final Function() startNewConversation;

  SideBar({required this.history, required this.currentConversation, required this.startNewConversation});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Peter"),
            accountEmail: Text("user@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
              radius: 40.0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Dialog ${index + 1}'),
                  onTap: () {
                    // 点击历史对话，恢复到历史对话内容
                    _startHistoricalConversation(history[index]);
                    Navigator.pop(context); // 关闭侧边栏
                  },
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("USER"),
            onTap: () {
              // 处理个人主页点击
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("New Chat"),
            onTap: () {
              startNewConversation();
              Navigator.pop(context); // 关闭侧边栏
            },
          ),
        ],
      ),
    );
  }

  void _startHistoricalConversation(List<String> conversation) {
    // 恢复到历史对话
    currentConversation.clear();
    currentConversation.addAll(conversation);
  }
}
