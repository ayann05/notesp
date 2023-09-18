import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notesp/notesscreen.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => notesscreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: content()),
    );
  }

  Widget content() {
    return Container(
      child: Lottie.asset(
        'assets/splashscreen/loading.json',
        width: 500,
        height: 500,
      ),
    );
  }
}
