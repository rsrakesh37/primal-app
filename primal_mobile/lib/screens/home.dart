import 'package:flutter/material.dart';
    Widget programCard() {
  return Card(
    color: Colors.white10,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    child: ListTile(
      leading: CircleAvatar(backgroundColor: Colors.white12, child: Icon(Icons.self_improvement, color: Color(0xFFFFD54F))),
      title: Text('Strength Balance', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('4 weeks · Beginner'),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Color(0xFFFFD54F)),
        child: Text('View'),
        onPressed: () {},
      ),
    ),
  );
}

    class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
          title: Text('Home', style: Theme.of(context).textTheme.headlineSmall),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: null)],
        ),
          body: LayoutBuilder(builder: (context, constraints) {
  bool isTablet = constraints.maxWidth > 600;
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.white10,
          child: ListTile(
            leading: Image.asset('assets/images/logo.png', width: 56),
            title: Text('Start 7-day Free Trial', style: TextStyle(color: Color(0xFFFFD54F), fontWeight: FontWeight.bold)),
            subtitle: Text('Unlock all programs and live classes'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Color(0xFFFFD54F)),
              onPressed: () {},
              child: Text('Start'),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text('Featured Programs', style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 8),
        Expanded(
          child: isTablet ? GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3,
            children: List.generate(6, (i) => programCard())
          ) : ListView(
            children: List.generate(6, (i) => programCard()).toList()
          ),
        )
      ],
    ),
  );
}),
        );
      }
    }
