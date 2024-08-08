import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_app/base/utils/app_routes.dart';
import 'package:ticket_app/provider/auth_provider.dart';
import 'package:http/http.dart' as http;

class LoginPage extends ConsumerWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    Future<void> _loginUser(String email, String password, WidgetRef ref) async {
      try{

        final url = Uri.parse('http://192.168.78.102:3001/login');
        print('Start fetch');
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': email,
            'password': password,
          }),
        );

        final responseData = jsonDecode(response.body);
        print(responseData);

        ref.read(authProvider.notifier).login(responseData['username'], email);
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      }catch (e){
        print('Network error: $e');

      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final password = _passwordController.text;
                    final email = _emailController.text;
                    _loginUser(email,password,ref);
                    // ref.read(authProvider.notifier).login('phuoc', email);
                    // Navigator.pushReplacementNamed(context, AppRoutes.homePage);
                  }
                },
                child: Text('Login')
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: Text("Don't have an account? Register here"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
