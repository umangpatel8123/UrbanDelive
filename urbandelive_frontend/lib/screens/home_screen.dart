import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/provider/auth_provider.dart';
import 'package:urbandelive/screens/welcome_screen.dart';
import 'package:urbandelive/utils/routes.dart';
import 'package:urbandelive/widgets/constant_colors.dart';
import 'package:urbandelive/widgets/navbar.dart';
import 'package:urbandelive/widgets/product_card.dart';
import '../constants/colors.dart';
import '../models/item_model.dart';
import '../widgets/text_input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: mobileBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 51,
                  backgroundColor: Colors.black.withOpacity(.5),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: mobileBackgroundColor,
                    child: Image.asset(
                      "image1.png",
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 51,
                  backgroundColor: Colors.black.withOpacity(.5),
                  child: InkWell(
                    onTap: () => {
                      Navigator.pushNamed(
                          context, MyRoute.searchbyBusinessRoute)
                    },
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'image2.png',
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 51,
                  backgroundColor: Colors.black.withOpacity(.5),
                  child: InkWell(
                    onTap: () => {
                      Navigator.pushNamed(
                          context, MyRoute.searchbyBusinessRoute)
                    },
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'image3.png',
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            'Your Favorites!!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // const TextInputField(
            //     hintText: "search", textInputType: TextInputType.name),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: Provider.of<AuthProvider>(context).allItems.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisExtent: 270,
                  ),
                  itemBuilder: (context, index) {
                    ItemModel item =
                        Provider.of<AuthProvider>(context).allItems[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle the click event here
                        print('ProductCard clicked');
                      },
                      child: ProductCard(
                        itemImage: item.image,
                        itemName: item.itemName,
                        itemPrice: item.price,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: NavBar(),
    );
  }
}
