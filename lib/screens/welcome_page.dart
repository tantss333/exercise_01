import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main_screen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x88E8EAF6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('resource/images/1.png', width: 200),
            SizedBox(height: 30),
            Text(
              "ENJOY YOUR SHOPPING",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Smart, gorgeous & fashionable\n",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MainScreen()),
                );
              },
              child: Text("Get Started", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
