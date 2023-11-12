import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/models/user_model.dart';
import 'package:urbandelive/screens/home_screen.dart';
import 'package:urbandelive/screens/user_detail.dart';
import 'package:urbandelive/utils/utils.dart';
import 'package:urbandelive/widgets/navbar.dart';
import '../provider/auth_provider.dart';
import '../utils/custom_textformfield.dart';

class UserEditDetail extends StatefulWidget {
  final String phoneNumber;
  const UserEditDetail({super.key, required this.phoneNumber});

  // ignore: recursive_getters
  // String get phoneNumber => phoneNumber;

  @override
  State<UserEditDetail> createState() => _UserEditDetailState();
}

class _UserEditDetailState extends State<UserEditDetail> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController add1 = TextEditingController();
  final TextEditingController add2 = TextEditingController();
  final TextEditingController bio = TextEditingController();

  DateTime _dateTime = DateTime.now();

  String _defaultDate = 'Date Of Birth';
  String _month = '';
  String _day = '';
  String _year = '';
  String _DOB = '';

  void updateDOB() {
    _DOB = '$_year-$_month-$_day';
  }

  File? _image;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        _month = _dateTime.month.toString();
        _day = _dateTime.day.toString();
        _year = _dateTime.year.toString();
        updateDOB();
        _defaultDate = _DOB;
      });
    });
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(
      () {
        _image = imageTemporary;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // email.selection = TextSelection.fromPosition(
    //   TextPosition(
    //     offset: email.text.length,
    //   ),
    // );

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
                    getImage();
                  },
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "Profile.png",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 30,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Enter username",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: email,
                      // onChanged: (value) => {
                      //   setState(() {
                      //     email.text = value;
                      //   })
                      // },
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        suffixIcon: email.text != ''
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => email.clear(),
                              )
                            : null,
                        hintText: "Email",
                      ),
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid Email'
                              : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: add1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: const Icon(Icons.location_on_sharp),
                      hintText: "Address Line 1",
                      // labelText: "Phone Number"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: add2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: const Icon(Icons.location_on_sharp),
                      hintText: "Address Line 2",
                      // labelText: "Phone Number"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bio,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: const Icon(Icons.bookmark_outlined),
                      hintText: "BIO",
                      // labelText: "Phone Number"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _showDatePicker();
                    },
                    child: Container(
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
                                _defaultDate, // Accessing the private variable inside the Text widget
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  color: Color.fromARGB(255, 121, 110, 110),
                                ),
                              ),
                            ),
                          ],
                        )),
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
                          final form = formKey.currentState!;

                          if (form.validate()) {
                            saveData();
                            // final e = email.text;
                            // ScaffoldMessenger.of(context)
                            //   ..removeCurrentSnackBar()
                            //   ..showSnackBar(
                            //       SnackBar(content: Text("Your email is $e")));
                          }
                        },
                        child: const Text(
                          "SAVE",
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

  void saveData() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel user = UserModel(
      uid: ap.uid,
      username: name.text,
      email: email.text,
      phoneNo: widget.phoneNumber,
      createdAt: DateTime.now().toString(),
      lastLogin: DateTime.now().toString(),
      dob: _DOB,
      bio: bio.text,
      addressLine1: add1.text,
      addressLine2: add2.text,
    );
    ap.saveUserDataToDjango(
        context: context,
        userModel2: user,
        onSuccess: () async {
          ap.saveUserDataToSP().then((value) async {
            await ap.setSignIn();
            // print(user.uid);
            // print(user.username);
            // print(user.email);
            // print(user.phoneNo);
            // print(user.createdAt);
            // print(user.lastLogin);
            // print(user.dob);
            // print(user.bio);
            // print(user.addressLine1);
            // print(user.addressLine2);
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const NavBar(),
              ),
              (route) => false,
            );
          });
        });
  }
}
