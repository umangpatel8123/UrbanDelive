import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/provider/auth_provider.dart';
import 'package:urbandelive/screens/edit_user_details.dart';
import 'package:urbandelive/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: "44",
    countryCode: "GB",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "United Kingdom",
    example: "UK",
    displayName: "UK",
    displayNameNoCountryCode: "UK",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    var isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;

    final inputborder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 50),
                      Image.asset('Logo.png'),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset('Carrier.png'),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            phoneController.text = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Enter your contact number",
                            border: inputborder,
                            focusedBorder: inputborder,
                            enabledBorder: inputborder,
                            fillColor: Colors.green,
                            contentPadding: const EdgeInsets.all(10),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                        bottomSheetHeight: 500,
                                      ),
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                        });
                                      });
                                },
                                child: Text(
                                  "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            suffixIcon: phoneController.text.length == 10
                                ? Container(
                                    height: 30,
                                    width: 30,
                                    margin: const EdgeInsets.all(7.0),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  )
                                : null),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          // FilteringTextInputFormatter.allow(),
                        ],
                        maxLength: 10,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (phoneController.text.trim().length != 10) {
                            showSnackBar(context, "Enter a valid number");
                          } else {
                            sendPhoneNumber();
                          }
                        },
                        style: const ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(300, 50))),
                        child: const Text(
                          "Get OTP",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
