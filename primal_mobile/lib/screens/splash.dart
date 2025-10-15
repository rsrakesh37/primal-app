import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primal Balance', style: Theme.of(context).textTheme.headlineSmall),
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 260),
            SizedBox(height: 30),
            Text('Balance. Strength. Focus.', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Color(0xFFFFD54F)),
              ),
              child: Text('Get Started', style: TextStyle(color: Color(0xFFFFD54F))),
              onPressed: () => Navigator.pushReplacementNamed(context, '/onboarding'),
            )
          ],
        ),
      ),
    );
  }
}
