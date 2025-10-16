import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/booking.dart';
import 'screens/library.dart';
import 'screens/account.dart';

void main() {
  runApp(PrimalBalanceApp());
}

class PrimalBalanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFFFD54F);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Primal Balance',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary: gold,
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: gold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        '/onboarding': (ctx) => OnboardingScreen(),
        '/login': (ctx) => LoginScreen(),
        '/home': (ctx) => HomeScreen(),
        '/booking': (ctx) => BookingScreen(),
        '/library': (ctx) => LibraryScreen(),
        '/account': (ctx) => AccountScreen(),
      },
    );
  }
}
