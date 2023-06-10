import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/models/user_model.dart';

import '../provider/auth_provider.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);
    UserModel user = ap.userModel;
    print(user.uid);
    print(user.username);
    print(user.email);
    print(user.addressLine1);
    print(user.addressLine2);
    print(user.bio);
    print(user.dob);
    print(user.phoneNo);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Your Details",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                InkWell(
                  onTap: () {
                    // getImage();
                  },
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Image.asset(
                          'profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 171, 153, 153),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 121, 110, 110),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            user.username, // Accessing the private variable inside the Text widget
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 121, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 171, 153, 153),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 121, 110, 110),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            user.email, // Accessing the private variable inside the Text widget
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 121, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 171, 153, 153),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.location_on_sharp,
                            color: Color.fromARGB(255, 121, 110, 110),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            user.addressLine1, // Accessing the private variable inside the Text widget
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 121, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 171, 153, 153),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.location_on_sharp,
                            color: Color.fromARGB(255, 121, 110, 110),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            user.addressLine2, // Accessing the private variable inside the Text widget
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 121, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 171, 153, 153),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.bookmark,
                            color: Color.fromARGB(255, 121, 110, 110),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            user.bio, // Accessing the private variable inside the Text widget
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 121, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 171, 153, 153),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(255, 121, 110, 110),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 9,
                          child: Text(
                            user.dob, // Accessing the private variable inside the Text widget
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 121, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 20,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, MyRoutes.userDetailRoute);
                          // final form = formKey.currentState!;

                          // if (form.validate()) {
                          //   controls();
                          //   final e = email.text;
                          //   ScaffoldMessenger.of(context)
                          //     ..removeCurrentSnackBar()
                          //     ..showSnackBar(
                          //         SnackBar(content: Text("Your email is $e")));
                          // }
                        },
                        child: const Text(
                          "Edit Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
