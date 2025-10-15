import 'package:flutter/material.dart';

    class BookingScreen extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Booking', style: Theme.of(context).textTheme.headlineSmall),
            actions: [],
          ),
          body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Upcoming Classes', style: Theme.of(context).textTheme.headlineSmall),
      SizedBox(height: 12),
      Expanded(
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (ctx, i) => Card(
            color: Colors.white10,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.calendar_today, color: Color(0xFFFFD54F)),
              title: Text('Sunrise Flow - Strength'),
              subtitle: Text('Tomorrow · 06:30 AM'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD54F), onPrimary: Colors.black),
                child: Text('Book'),
                onPressed: () {},
              ),
            ),
          ),
        ),
      )
    ],
  ),
)
,
          bottomNavigationBar: null,
        );
      }
    }
