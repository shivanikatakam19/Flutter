import 'package:flutter/material.dart';

class ProfileStatelessWidget extends StatelessWidget {
  const ProfileStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200, // set width
          height: 100, // set height
          child: Image.asset('assets/cognine-logo.png', fit: BoxFit.contain),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            Image.asset('assets/profile-image.png'),
            SizedBox(height: 10.0),
            Text(
              'SHIVANI KATAKAM',
              style: TextStyle(
                color: const Color.fromARGB(255, 10, 62, 89),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ID # 141',
              style: TextStyle(
                color: const Color.fromARGB(255, 10, 62, 89),
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/todoList");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('View Todos'),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 80.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Text(
              'COGNINE TECHNOLOGIES PVT.LTD.',
              style: TextStyle(
                color: const Color.fromARGB(255, 10, 62, 89),
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '207, Kavuri Hills Phase 2, Madhapur, Hyderabad - 500033 - India',
              style: TextStyle(
                color: const Color.fromARGB(255, 10, 62, 89),
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '+91 90300 22800 | +91 99086 03524 | info@cognine.com | www.cognine.com',
              style: TextStyle(
                color: const Color.fromARGB(255, 10, 62, 89),
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
