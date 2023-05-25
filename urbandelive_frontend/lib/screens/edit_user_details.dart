import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urbandelive/utils/custom_textformfield.dart';

class UserEditDetail extends StatefulWidget {
  const UserEditDetail({super.key});

  @override
  State<UserEditDetail> createState() => _UserEditDetailState();
}

class _UserEditDetailState extends State<UserEditDetail> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            // Container(
            //   child: const SizedBox(
            //     height: 60,
            //   ),
            // ),
            Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // children: [
                //   const Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 10),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 30,
                //     ),
                //   ),
                //   const Expanded(
                //     child: Align(
                //       // alignment: Alignment.center,
                //       child: Text(
                //         "Edit Your Details",
                //         style: TextStyle(fontSize: 30),
                //       ),
                //     ),
                //   ),
                // ],
                ),
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
                                'assets/profile.png',
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
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'First Name',
              textInputType: TextInputType.name,
              icon: Icon(Icons.person),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'Last name',
              textInputType: TextInputType.name,
              icon: Icon(Icons.person_2),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'Email',
              textInputType: TextInputType.name,
              icon: Icon(Icons.mail),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'Date of Birth',
              textInputType: TextInputType.name,
              icon: Icon(Icons.calendar_month),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'Contact Number',
              textInputType: TextInputType.name,
              icon: Icon(Icons.phone),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'Address Line 1',
              textInputType: TextInputType.name,
              icon: Icon(Icons.my_location_outlined),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextInputField(
              hintText: 'Address Line 2',
              textInputType: TextInputType.name,
              icon: Icon(Icons.my_location_outlined),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 20,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "SAVE",
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
    );
  }
}
