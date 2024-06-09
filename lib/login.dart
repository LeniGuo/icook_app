import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              obscureText: false,
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // 从SharedPreferences获取已注册的用户信息
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String storedUsername = prefs.getString('username')!;
                String storedPassword = prefs.getString('password')!;

                // 验证用户名和密码
                if (_usernameController.text == storedUsername && _passwordController.text == storedPassword) {
                  // 登录成功，跳转到主页面
                  Navigator.of(context).pushReplacementNamed('/');
                } else {
                  // 登录失败，显示错误信息
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User name or password wrong')));
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            // 添加“没有账号？去注册”的按钮或链接
            TextButton(
              onPressed: () {
                // 跳转到注册页面
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text('No account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}