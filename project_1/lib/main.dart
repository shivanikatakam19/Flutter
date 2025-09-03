// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Widgets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Center(child: Image.asset('assets/profile-image.png')),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
              ),
              child: Text('Click me!'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              style: IconButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
            Container(
              alignment: AlignmentGeometry.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("I'm in a container towards the right side"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
