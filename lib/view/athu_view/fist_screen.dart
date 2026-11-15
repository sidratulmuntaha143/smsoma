import 'package:flutter/material.dart';

class FistScreen extends StatelessWidget {
  const FistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlue
            ],

          ),

        ),
        child: Center(
          child: Text('UX',
          style: TextStyle(
            fontSize: 200,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          ),
        ),
      )
    );
  }
}
