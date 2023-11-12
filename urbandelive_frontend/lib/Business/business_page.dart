import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../models/item_model.dart';
import '../provider/auth_provider.dart';
import '../widgets/product_card.dart';

class BussinessDetailsPage extends StatefulWidget {
  final dynamic requiredObject; // Add a required object property
  const BussinessDetailsPage({Key? key, required this.requiredObject})
      : super(key: key);

  @override
  State<BussinessDetailsPage> createState() => _BussinessDetailsPageState();
}

class _BussinessDetailsPageState extends State<BussinessDetailsPage> {
  List<ItemModel> allItems = [];
  bool _isLoading = true;
  @override
  @override
  void initState() {
    super.initState();
    for (int j = 0; j < widget.requiredObject.categories.length; j++) {
      // List<ItemModel> fetchedItems =
      //     ItemModel.fromMapList(widget.requiredObject.categories[j].items);
      // // _items = fetchedItems;
      // allItems.addAll(fetchedItems);
    }
    for (var e in widget.requiredObject.categories) {
      for (var f in e.items) {
        // print(f.itemName);
        allItems.add(f);
      }
    }

    // print(widget.requiredObject.categories);
    // for (int i = 0; i < widget.requiredObject.categories.length; i++) {
    //   for (int j = 0;
    //       j < widget.requiredObject.categories[i].items.length;
    //       j++) {
    //   }
    // }
    init();
  }

  Future<void> init() async {
    setState(() {
      _isLoading = true;
    });
    // print(widget.requiredObject.categories[1].items[0].itemName);
    // for (int i = 0; i < widget.requiredObject.categories.length; i++) {
    //   for (int j = 0;
    //       j < widget.requiredObject.categories[i].items.length;
    //       j++) {
    //     // print(widget.requiredObject.categories[i].items[j].itemName);
    //   }
    //   // print(widget.requiredObject.categories[i].items);
    // }
    setState(() {
      _isLoading = false;
    });
  }

  // Future<void> fetchCategories(dynamic e) async {
  //   var url = Uri.parse("http://127.0.0.1:8000/allBusinesses/");
  //   http.Response response = await http.get(url);
  //   dynamic res = jsonDecode(response.body);
  //   // print(res["businesses"][1]["categories"]);
  //   // Access the BusinessProvider instance and update the businesses list
  // }

  // dynamic categories=requiredObject['categories'];
  // bool isOpen = requiredObject.isActive;
  @override
  Widget build(BuildContext context) {
    // final ap = Provider.of<AuthProvider>(context, listen: true);
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23 - 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'http://127.0.0.1:8000/${widget.requiredObject.businessLogo}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23 - 20,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, right: 20, left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFD9D9D9).withOpacity(.26),
                  ),
                  height: MediaQuery.of(context).size.height * .15,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                widget.requiredObject.businessName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width:
                                  120, // Adjust the width as per your preference
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    // isOpen = !isOpen;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    widget.requiredObject.isActive
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: widget.requiredObject.isActive
                                    ? const Text(
                                        'OPEN',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const Text(
                                        'CLOSED',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: buttonBackgroundColor,
                                            size: 13,
                                          ),
                                          Text(
                                            "4.6/5",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Distance",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: buttonBackgroundColor,
                                            size: 13,
                                          ),
                                          Text(
                                            "12km",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.map,
                                            color: buttonBackgroundColor,
                                            size: 13,
                                          ),
                                          Text(
                                            "London",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Delivery Time",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: buttonBackgroundColor,
                                            size: 13,
                                          ),
                                          Text(
                                            "30 min",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      itemCount:
                          // Provider.of<AuthProvider>(context).
                          allItems.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        mainAxisExtent: 270,
                      ),
                      itemBuilder: (context, index) {
                        ItemModel item =
                            // Provider.of<AuthProvider>(context).
                            allItems[index];
                        return ProductCard(
                          itemImage: item.image,
                          itemName: item.itemName,
                          itemPrice: item.price,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
