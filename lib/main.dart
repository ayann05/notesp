import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesp/splash.dart';

void main() {
  runApp(notesp());
}

class notesp extends StatelessWidget {
  const notesp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryTextTheme: GoogleFonts.latoTextTheme(),
      ),
      routes: {
        '/': (context) => splash(),
      },
    );
  }
}
