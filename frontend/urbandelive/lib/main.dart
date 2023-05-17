import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urbandelive/screens/loginpage.dart';

void main() {
  runApp(const UrbanDelive());
}

class UrbanDelive extends StatelessWidget {
  const UrbanDelive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UrbanDelive",
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const LoginScreen(),
    );
  }
}
