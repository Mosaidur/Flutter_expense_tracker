import 'dart:async';

import 'package:expense_tracker/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration (seconds: 5),() {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      HomePage(),
      )
      );

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color(0xfff0e0e0) ,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 150,
                child: Image.asset( "img/analytics.png")),
            Text("Expense Tracker",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.blue),),
          ],
        ),
      ),
    );
  }
}
