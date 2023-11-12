import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/Business/business_page.dart';
import 'package:urbandelive/provider/auth_provider.dart';
import '../models/business_model.dart';
import '../utils/routes.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchByBusiness extends StatefulWidget {
  const SearchByBusiness({super.key});

  @override
  State<SearchByBusiness> createState() => _SearchByBusinessState();
}

class _SearchByBusinessState extends State<SearchByBusiness> {
  // List<BusinessModel> businesses = [];
  // bool _isLoading = true;
  // @override
  // @override
  // void initState() {
  //   super.initState();
  //   init();
  // }

  // Future<void> init() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await fetchBusinesses();
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // Future<void> fetchBusinesses() async {
  //   var url = Uri.parse("http://127.0.0.1:8000/allBusinesses/");
  //   http.Response response = await http.get(url);
  //   dynamic res = jsonDecode(response.body);

  //   businesses = BusinessModel.fromMapList(res["businesses"]);
  //   print(businesses.length);
  // }

  @override
  Widget build(BuildContext context) {
    // final bp = Provider.of<BusinessProvider>(context, listen: true);
    final ap = Provider.of<AuthProvider>(context, listen: true);

    return ap.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                fillColor: Color.fromARGB(255, 73, 209, 77),
              ),
            ),
            home: Scaffold(
              // appBar: AppBar(
              //   iconTheme: const IconThemeData(color: Colors.black),
              //   shadowColor: Colors.white,
              //   centerTitle: true,
              //   flexibleSpace: Container(
              //     decoration: const BoxDecoration(
              //         // image: DecorationImage(
              //         //   image: AssetImage("assets/images/AppBar.png"),
              //         //   fit: BoxFit.fill,
              //         // ),
              //         ),
              //   ),
              //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
              //   toolbarHeight: 50,
              //   title: const Text(
              //     "Find businesses here",
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 30,
              //     ),
              //   ),
              // ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Handle the back button tap here
                            // You can navigate back or perform any other desired action
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Find businesses here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 12),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Search nearby business",
                          labelText: "Search nearby business",
                          suffixIcon: const Icon(Icons.search)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: ap.businesses.map(
                          (e) {
                            return GestureDetector(
                              onTap: () {
                                // Handle the click event here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BussinessDetailsPage(requiredObject: e),
                                  ),
                                );
                                // 'Image ${ap.businesses.indexOf(e)} clicked!'
                              },
                              child: Padding(
                                padding: EdgeInsets.all(
                                    8.0), // Add padding around each grid item
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 15,
                                        offset: const Offset(3,
                                            8), // changes the position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    'http://127.0.0.1:8000/${e.businessLogo}',
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 40, 228, 131),
                      ),
                      child: Text(
                        'Account Settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.business),
                      title: const Text(
                        'Switch to Business Account',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, MyRoutes.businessRoute);
                        // Do something when the menu item is tapped.
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.delivery_dining_outlined),
                      title: const Text(
                        'Switch to Carrier Account',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, MyRoutes.carrierRoute);
                        // Do something when the menu item is tapped.
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, MyRoutes.loginRoute);
                        // Do something when the menu item is tapped.
                      },
                    ),
                    // Add more menu items as needed.
                  ],
                ),
              ),
            ),
          );
  }
}
