import 'package:flutter/material.dart';
import 'package:urbandelive/widgets/constant_colors.dart';
import 'package:urbandelive/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/Logo.png'),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/Carrier.png'),
              ),
              const SizedBox(height: 30),
              const TextInputField(
                  hintText: "Enter your contact number",
                  textInputType: TextInputType.numberWithOptions(
                      signed: false, decimal: false)),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
