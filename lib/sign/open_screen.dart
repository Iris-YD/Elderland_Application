import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';


class OpenScreen extends StatefulWidget {
  OpenScreen({Key? key}) : super(key: key);

  @override
  _OpenScreenState createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  late Timer timer;
  int currentTime = 6;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        Duration(milliseconds: 1000),
            (timer) {
          setState(() {
            currentTime--;
          });
          if(currentTime <= 0){
            jumpRootPage();
          }
        });
  }

  // skip to home page
  void jumpRootPage() {
    timer.cancel();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/openp2.jpeg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top +10,
            right: 20,
            child: InkWell(
              child: _clipButtion(),
              onTap: jumpRootPage,
            ),

          )
        ],
      ),
    );
  }
  // Skip Button
  Widget _clipButtion() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
          width: 50,
          height: 50,
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Skip',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                '${currentTime}s',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          )
      ),
    );
  }
}

