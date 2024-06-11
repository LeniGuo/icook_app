import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icook/user.dart';
class SideBar extends StatefulWidget {
  final List<List<String>> history;
  final List<String> currentConversation;
  final Function() startNewConversation;

  SideBar({
    required this.history,
    required this.currentConversation,
    required this.startNewConversation,
  });

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String? username;
  String? email;

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    email = prefs.getString('email');
    // 更新UI
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(username ?? 'Guest'),
            accountEmail: Text(email ?? 'guest@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
              radius: 40.0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Chat ${index + 1}'),
                  onTap: () {
                    // 点击历史对话，恢复到历史对话内容
                    _startHistoricalConversation(widget.history[index]);
                    Navigator.pop(context); // 关闭侧边栏
                  },
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Personal homepage"),
            onTap: () {
              // 处理个人主页点击
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
                //MaterialPageRoute(builder: (context) => RecipeDetailPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("New Chat"),
            onTap: () {
              widget.startNewConversation();
              Navigator.pop(context); // 关闭侧边栏
            },
          ),
        ],
      ),
    );
  }

  void _startHistoricalConversation(List<String> conversation) {
    // 恢复到历史对话
    widget.currentConversation.clear();
    widget.currentConversation.addAll(conversation);
  }
}
