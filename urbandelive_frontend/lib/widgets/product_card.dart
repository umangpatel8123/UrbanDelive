import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ProductCard extends StatefulWidget {
  final String itemName;
  final String itemImage;
  final String itemPrice;
  const ProductCard({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),

      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.grey.withOpacity(0.2),
        //       blurRadius: 15.0,
        //       offset: const Offset(3, 8))
        // ],
        borderRadius: BorderRadius.circular(18),
        color: const Color.fromARGB(255, 243, 243, 243),
      ),
      height: 600,
      // width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Image.network(
                'http://127.0.0.1:8000/${widget.itemImage}',
                // width: MediaQuery.of(context).size.width * 0.2,
                // height: MediaQuery.of(context).size.height * 0.2,
                // Adjust the width as needed
                // Additional image properties...
              ),
            ),
          ),
          Text(
            widget.itemName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.itemPrice,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                const Icon(
                  Icons.star,
                  color: buttonBackgroundColor,
                  size: 13,
                ),
              Text(
                '(13)',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black.withOpacity(.5),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const Text(
            'H&M, London',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: isSelected
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: buttonBackgroundColor,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
