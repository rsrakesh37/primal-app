import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: Theme.of(context).textTheme.headlineSmall),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.white12, child: Icon(Icons.person, color: Color(0xFFFFD54F))),
              title: Text('Rakesh Sharma'),
              subtitle: Text('Member — Trial: 6 days left'),
            ),
            SizedBox(height: 12),
            Card(
              color: Colors.white10,
              child: ListTile(
                leading: Icon(Icons.credit_card, color: Color(0xFFFFD54F)),
                title: Text('Payment Method'),
                subtitle: Text('**** **** **** 4242'),
                trailing: TextButton(onPressed: () {}, child: Text('Manage', style: TextStyle(color: Color(0xFFFFD54F)))),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, side: BorderSide(color: Color(0xFFFFD54F))),
              child: Text('Logout', style: TextStyle(color: Color(0xFFFFD54F))),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
