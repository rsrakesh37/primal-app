import 'package:flutter/material.dart';

    class OnboardingScreen extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
        title: Text('Welcome', style: Theme.of(context).textTheme.headlineSmall),
      ),
            actions: [],
          ),
          body: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/logo.png', width: 220),
      SizedBox(height: 30),
      Text('7-day Free Trial', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Text('Join programs designed for men. Strength, mobility and calm — no fluff.', textAlign: TextAlign.center),
      SizedBox(height: 20),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD54F), onPrimary: Colors.black),
        child: Text('Start Free Trial'),
        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
      ),
    ],
  ),
)
,
          bottomNavigationBar: null,
        );
      }
    }
