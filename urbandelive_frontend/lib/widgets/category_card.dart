import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title, tagline, imageUrl;
  const CategoryCard(
      {super.key,
      required this.title,
      required this.tagline,
      required this.imageUrl});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: .8,
          image: NetworkImage(widget.imageUrl),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 15.0,
              offset: const Offset(3, 8))
        ],
        borderRadius: BorderRadius.circular(18),
        color: Colors.black,
      ),
      height: 255,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (widget.title),
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.tagline,
            style: const TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Center(),
        ],
      ),
    );
  }
}
