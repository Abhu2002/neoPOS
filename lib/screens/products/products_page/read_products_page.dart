import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsRead extends StatefulWidget {
  const ProductsRead({super.key});

  @override
  State<ProductsRead> createState() => _ProductsReadState();
}

class _ProductsReadState extends State<ProductsRead> {
  List<String> category = [
    "All",
    "Stater",
    "Main Course",
    "Dessert menu",
    "Children's",
  ];
  List<Map> data = [
    {
      "product_availability": true,
      "product_category": "Starter",
      "product_description":
          "This is an Indo-Chinese dish with schezwan sauce. It has spicy-sweet taste.",
      "product_image": "assets/chicken-crispy.png",
      "product_name": "Chicken crispy",
      "product_price": 300,
      "product_type": "Non-veg"
    },
    {
      "product_availability": true,
      "product_category": "Main Course",
      "product_description":
          "This is an Indo-Chinese dish with schezwan sauce. It has spicy-sweet taste.",
      "product_image": "assets/chicken-crispy.png",
      "product_name": "Chicken crispy",
      "product_price": 300,
      "product_type": "Non-veg"
    },
    {
      "product_availability": true,
      "product_category": "Children's",
      "product_description":
          "This is an Indo-Chinese dish with schezwan sauce. It has spicy-sweet taste.",
      "product_image": "assets/chicken-crispy.png",
      "product_name": "Chicken crispy",
      "product_price": 300,
      "product_type": "Non-veg"
    },
    {
      "product_availability": true,
      "product_category": "Children's",
      "product_description":
          "This is an Indo-Chinese dish with schezwan sauce. It has spicy-sweet taste.",
      "product_image": "assets/chicken-crispy.png",
      "product_name": "Chicken crispy",
      "product_price": 300,
      "product_type": "Non-veg"
    },
    {
      "product_availability": true,
      "product_category": "Dessert menu",
      "product_description":
          "This is an Indo-Chinese dish with schezwan sauce. It has spicy-sweet taste.",
      "product_image": "assets/chicken-crispy.png",
      "product_name": "Chicken crispy",
      "product_price": 300,
      "product_type": "Non-veg"
    },
    {
      "product_availability": true,
      "product_category": "Main Course",
      "product_description":
          "This is an Indo-Chinese dish with schezwan sauce. It has spicy-sweet taste.",
      "product_image": "assets/chicken-crispy.png",
      "product_name": "Chicken crispy",
      "product_price": 300,
      "product_type": "Non-veg"
    },
  ];
  String selectedCat = "All";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  ElevatedButton(onPressed: () {}, child: const Text("Create")),
            ),
          ),
        ],
      ),
      DropdownButton<String>(
        value: selectedCat,
        items: category.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 30),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCat = value!;
          });
        },
      )
    ]);
  }
}
