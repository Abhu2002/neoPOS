import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';

class TopFiveProduct extends StatefulWidget {
  final data;
  const TopFiveProduct({super.key, this.data});

  @override
  State<TopFiveProduct> createState() => _TopFiveProductState();
}

class _TopFiveProductState extends State<TopFiveProduct> {
  @override
  void initState() {
    super.initState();
    sortedtopproduct = SplayTreeMap.from(widget.data,
        (key1, key2) => widget.data[key2].compareTo(widget.data[key1]));
  }

  String dropdownvalue = 'Daily';

  // List of items in our dropdown menu
  var items = ["Daily", "Weekly", "Monthly"];

  var sortedtopproduct;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 265,
        child: Column(children: [
          SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Top 5 Products",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  String key = sortedtopproduct.keys.elementAt(index);
                  return Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "${index + 1}.",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                            )),
                        Expanded(flex: 4, child: Text(key))
                      ]),
                    ),
                  );

                  // return ListTile(
                  //   leading: Text("${index + 1}"),
                  //   title: Text(key),
                  //   // trailing: Text("${sortedtopproduct[key]}"),
                  // );
                }),
          )
        ]),
      ),
    );
  }
}
