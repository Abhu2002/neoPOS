import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';

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
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                mainAxisExtent: 450,
              ),
              itemBuilder: (context, i) {
                return Container(
                  // color: Colors.orange.shade50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor),
                  child: Column(children: [
                    Stack(
                      children: [
                        Image.network(
                            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              initialValue: "",
                              icon: const Icon(Icons.menu,
                                  color: AppColors.primaryColor),
                              color: Colors.white,
                              itemBuilder: (context) => <PopupMenuEntry>[
                                const PopupMenuItem(
                                    value: "",
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                const PopupMenuItem(
                                    value: "",
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Chicken crispy",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rs 300",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ]),
                );
              }),
        ),
      ),
    ]);
  }
}
