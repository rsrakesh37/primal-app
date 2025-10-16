import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash.dart';
import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/booking.dart';
import 'screens/library.dart';
import 'screens/account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PrimalBalanceApp());
}

class PrimalBalanceApp extends StatelessWidget {
  const PrimalBalanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Primal Balance - Men\'s Yoga',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.amber,
          tertiary: Colors.deepPurple,
          surface: Colors.grey[900]!,
          onSurface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
          bodyMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.amber),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.grey[900],
          elevation: 8,
          shadowColor: Color.fromRGBO(Colors.amber.red, Colors.amber.green, Colors.amber.blue, 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
