import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    // 初始化SharedPreferences并加载已存储的用户信息
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    _prefs = await SharedPreferences.getInstance();
    String? username = _prefs.getString('username');
    String? password = _prefs.getString('password');
    String? email = _prefs.getString('email');
    // 将已存储的信息设置到控制器中
    _usernameController.text = username ?? '';
    _passwordController.text = password ?? '';
    _emailController.text = email ?? '';
  }
  Future<void> _updateUserInfo() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    // 将更新后的信息保存到SharedPreferences中
    await _prefs.setString('username', username);
    await _prefs.setString('password', password);
    await _prefs.setString('email', email);
    // 显示更新成功的消息或执行其他操作
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User info updated successfully')));
    Navigator.pushReplacementNamed(context, '/login');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true, // 隐藏密码
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text.isEmpty || _passwordController.text.isEmpty || _emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please complete all infomation!')));
                  return;
                }
                await _updateUserInfo();
                },
              child: Text('Save'),
              ),
            ],
          ),
        ),
      );
    }
    @override
    void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
