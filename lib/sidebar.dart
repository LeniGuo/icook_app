import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("用户姓名"),
            accountEmail: Text("user@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 假设历史消息有10条
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("历史消息 ${index + 1}"),
                  onTap: () {
                    // 处理历史消息点击
                  },
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("个人主页"),
            onTap: () {
              // 处理个人主页点击
            },
          ),
        ],
      ),
    );
  }
}
