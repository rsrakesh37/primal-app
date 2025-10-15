import 'package:flutter/material.dart';

    class LoginScreen extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
        title: Text('Login', style: Theme.of(context).textTheme.headlineSmall),
      ),
            actions: [],
          ),
          body: SingleChildScrollView(
  padding: EdgeInsets.all(20),
  child: Column(
    children: [
      SizedBox(height: 20),
      TextField(
        decoration: InputDecoration(labelText: 'Email', filled: true, fillColor: Colors.white10),
        keyboardType: TextInputType.emailAddress,
      ),
      SizedBox(height: 12),
      TextField(
        decoration: InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white10),
        obscureText: true,
      ),
      SizedBox(height: 20),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD54F), onPrimary: Colors.black),
        child: SizedBox(width: double.infinity, child: Center(child: Text('Login'))),
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
      SizedBox(height: 12),
      TextButton(onPressed: () {}, child: Text('Forgot password?', style: TextStyle(color: Colors.white70))),
    ],
  ),
)
,
          bottomNavigationBar: null,
        );
      }
    }
