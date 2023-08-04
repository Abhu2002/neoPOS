
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_page/moreinfo_dialog.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';
import 'package:neopos/utils/app_colors.dart';

class ProductsRead extends StatefulWidget {
  const ProductsRead({super.key});

  @override
  State<ProductsRead> createState() => _ProductsReadState();
}

class _ProductsReadState extends State<ProductsRead> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReadProductsBloc>(context).add(ReadInitialEvent());
  }

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
      BlocBuilder<ReadProductsBloc, ReadProductsState>(
        builder: ((context, state) {
          if (state is ReadDataLoadedState) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height - 174,
                  child: ListView.separated(
                    //shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 2,
                        color: Colors.grey.shade200,
                      );
                    },
                    itemCount: state.allProducts.length,
                    itemBuilder: (context, index) {
                      var data = state.allProducts[index];
                      if (index == 0) {
                        // return the header
                        return Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 50,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Row(
                            children: [
                              // SizedBox(width: 10),
                              Container(
                                  width: 80,
                                  child: const Center(
                                      child: Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor),
                                  ))),
                              const SizedBox(width: 20),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<ReadProductsBloc, ReadProductsState>(
          builder: (context, state) {
            if (state is ReadDataLoadedState) {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: DataTable(
                  showBottomBorder: true,
                  headingRowHeight: 60,
                  // columnSpacing: 2,
                  headingTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainTextColor),
                  // Use the default value.

                              Container(
                                  width: 100,
                                  child: const Center(
                                      child: Text(
                                    "Image",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor),
                                  ))),
                              const SizedBox(
                                width: 80,
                              ),
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Product Name",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor),
                                  )),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                  width: 60,
                                  child: const Center(
                                      child: Text(
                                    "Type",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor),
                                  ))),
                              const SizedBox(
                                width: 60,
                              ),
                              const Expanded(
                                  child: Center(
                                      child: Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor),
                              ))),
                              const Expanded(
                                  child: Center(
                                child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primaryColor),
                                ),
                              )),
                              // Text("More"),
                            ],
                          ),
                        );
                      }

                      return Container(
                        width: 100,
                        height: 100,
                        child: Row(children: [
                          Container(
                            width: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("1 Aug")),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['product_name'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data['product_description'].length > 50
                                      ? data['product_description']
                                              .substring(0, 50) +
                                          '...'
                                      : data['product_description'],
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 20,
                            width:
                                (data['product_type'] == "Non-veg") ? 60 : 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (data['product_type']) == "Non-veg"
                                    ? Colors.red
                                    : Colors.green),
                            child: Center(
                              child: Text(
                                (data['product_type'] == "Non-veg")
                                    ? "Non-Veg"
                                    : "Veg",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                (data['product_type'] == "Non-veg") ? 30 : 60,
                          ),
                          Expanded(
                              child: Center(
                                  child: Text(data["product_category"]!))),
                          Expanded(
                              child: Center(
                                  child: Text("Rs ${data["product_price"]!}"))),
                        ]),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Text("Loading");
        }),
      )
    ]);
  }
}
