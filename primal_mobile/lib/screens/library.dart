import 'package:flutter/material.dart';
    Widget videoCard() {
  return Card(
    color: Colors.white10,
    child: Stack(
      children: [
        Center(child: Icon(Icons.play_circle_outline, size: 48, color: Colors.white30)),
        Positioned(
          bottom: 8, left: 8,
          child: Text('20:12', style: TextStyle(fontSize: 12)),
        )
      ],
    ),
  );
}

    class LibraryScreen extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
        title: Text('Library', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Video Library', style: Theme.of(context).textTheme.headlineSmall),
      SizedBox(height: 12),
      Expanded(
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 700 ? 3 : 2,
          childAspectRatio: 16/9,
          children: List.generate(8, (i) => videoCard()).toList(),
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
