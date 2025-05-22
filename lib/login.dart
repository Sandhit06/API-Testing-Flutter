import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'user_list.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserListPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text('Sign In to continue', style: TextStyle(fontSize: 18)),
              SizedBox(height: 26),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              ),
              SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  child: Text(isLoading ? 'Logging in...' : 'Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
