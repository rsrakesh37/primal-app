import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget programCard(String title, String subtitle, IconData icon, Color accentColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[900]!, Colors.black87],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(accentColor.red, accentColor.green, accentColor.blue, 0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentColor, Color.fromRGBO(accentColor.red, accentColor.green, accentColor.blue, 0.7)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        title: Text(
          title, 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.white,
            fontSize: 18,
          )
        ),
        subtitle: Text(
          subtitle, 
          style: TextStyle(color: Colors.grey[300], fontSize: 14)
        ),
        trailing: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentColor, Color.fromRGBO(accentColor.red, accentColor.green, accentColor.blue, 0.8)],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text('START', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'PRIMAL BALANCE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.star, color: Colors.amber, size: 24),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.indigo, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(Colors.deepPurple.red, Colors.deepPurple.green, Colors.deepPurple.blue, 0.4),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fitness_center, color: Colors.white, size: 32),
                          SizedBox(width: 12),
                          Text(
                            'MEN\'S YOGA MASTERY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Build strength, flexibility & mental focus',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.amber, Colors.orange],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          ),
                          onPressed: () {},
                          child: Text(
                            'START 7-DAY FREE TRIAL',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'POWER PROGRAMS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: isTablet ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    children: [
                      programCard('WARRIOR STRENGTH', '6 weeks • Advanced', Icons.fitness_center, Colors.red),
                      programCard('CORE POWER', '4 weeks • Intermediate', Icons.sports_gymnastics, Colors.orange),
                      programCard('FLEXIBILITY FLOW', '3 weeks • Beginner', Icons.self_improvement, Colors.green),
                      programCard('BALANCE MASTERY', '5 weeks • Intermediate', Icons.balance, Colors.blue),
                      programCard('STRESS CRUSHER', '2 weeks • All Levels', Icons.psychology, Colors.purple),
                      programCard('MORNING ENERGY', '4 weeks • Beginner', Icons.wb_sunny, Colors.amber),
                    ]
                  ) : ListView(
                    children: [
                      programCard('WARRIOR STRENGTH', '6 weeks • Advanced', Icons.fitness_center, Colors.red),
                      programCard('CORE POWER', '4 weeks • Intermediate', Icons.sports_gymnastics, Colors.orange),
                      programCard('FLEXIBILITY FLOW', '3 weeks • Beginner', Icons.self_improvement, Colors.green),
                      programCard('BALANCE MASTERY', '5 weeks • Intermediate', Icons.balance, Colors.blue),
                      programCard('STRESS CRUSHER', '2 weeks • All Levels', Icons.psychology, Colors.purple),
                      programCard('MORNING ENERGY', '4 weeks • Beginner', Icons.wb_sunny, Colors.amber),
                    ]
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
