import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
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
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
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
                String storedUsername = prefs.getString('email')!;
                String storedPassword = prefs.getString('password')!;

                // 验证用户名和密码
                if (_emailController.text == storedUsername && _passwordController.text == storedPassword) {
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
/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final String url = 'http://localhost:6006/login/';

      final Map<String, String> formData = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      formData.forEach((key, value) {
        var formField = http.MultipartFile.fromString(key, value);
        request.files.add(formField);
      });
      try {
        var response = await request.send();
        if (response.statusCode == 200 || response.statusCode == 201) {
          // 注册成功，处理成功逻辑
          print('Login successful!');
          // 跳转到主页面
          Navigator.of(context).pushReplacementNamed('/');
        } else {
          // 注册失败，处理错误逻辑
          print('Login failed with status: ${response.statusCode}');
        }

        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
      } on http.ClientException catch (e) {
        // 处理网络异常
        print('An error occurred: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login, // 使用我们定义的_login函数
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
*/