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
      "product_type": "veg"
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
      DataTable(
        showBottomBorder: true,
        headingRowHeight: 60,
        headingTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor),
        // Use the default value.

        columns: const [
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Image")),
          DataColumn(label: Flexible(child: Text('Product Name'))),
          DataColumn(label: Text("Type")),
          DataColumn(label: Text("Category")),
          DataColumn(label: Flexible(child: Text('Price'))),
          DataColumn(label: Text('More Details')),
        ],
        rows:
            data // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          //Extracting from Map element the value
                          DataCell(Text("1 Aug")),
                          DataCell(Container(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                              width: 55,
                            ),
                          ))),
                          DataCell(Text(element["product_name"]!)),
                          DataCell(Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (element['product_type']) == "Non-veg"
                                    ? Colors.red
                                    : Colors.green),
                          )),
                          DataCell(Text(element["product_category"]!)),
                          DataCell(Text("${element["product_price"]!}")),

                          DataCell(Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.info_outline,
                                      color: AppColors.mainTextColor,
                                    )),
                              ),
                            ],
                          )),
                        ],
                      )),
                )
                .toList(),
      ),
    ]);
  }
}
