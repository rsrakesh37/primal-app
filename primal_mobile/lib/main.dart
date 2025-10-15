import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primal Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primal Mobile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('Terms of Service'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_outlined),
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App logo
              SizedBox(
                height: 96,
                child: Image(
                  image: AssetImage('assets/images/primallogo.png'),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to Primal Mobile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Use the menu to navigate to About, Settings, Privacy Policy, Terms, and Contact pages.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('About content goes here. This will be replaced with details from SRS.'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Theme'),
            subtitle: Text('Follows system by default'),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Privacy policy placeholder. Will be updated from SRS and legal docs.'),
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Terms of service placeholder. Will be updated from SRS and legal docs.'),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Contact us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Email: support@example.com'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Send feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
