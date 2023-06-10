import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/provider/auth_provider.dart';
import 'package:urbandelive/screens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(ap.userModel.phoneNo),
      ),
      body: ElevatedButton(
          onPressed: () {
            ap.userSignOut().then(
                  (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  ),
                );
          },
          child: const Text("Logout")),
    );
  }
}
