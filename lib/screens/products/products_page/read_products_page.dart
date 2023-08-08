import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_page/moreinfo_dialog.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/screens/products/products_operation/create_operation/create_product_dialog.dart';
import 'package:intl/intl.dart'; // for date format

class ProductsRead extends StatefulWidget {
  const ProductsRead({super.key});

  @override
  State<ProductsRead> createState() => _ProductsReadState();
}

class _ProductsReadState extends State<ProductsRead> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReadProductsBloc>(context).add(ReadInitialEvent(true));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Product Page",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    minimumSize: const Size(88, 36),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {
                  showDialog(
                          context: context,
                          builder: (context) => const CreateProductForm())
                      .then((value) =>
                          BlocProvider.of<ReadProductsBloc>(context)
                              .add(ReadInitialEvent(false)));
                },
                child: const Text("Create")),
          ),
        ),
      ]),
      BlocBuilder<ReadProductsBloc, ReadProductsState>(
        builder: ((context, state) {
          if (state is ReadDataLoadedState) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height - 144,
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

                      return InkWell(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Row(children: [
                            Container(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(DateFormat.MMMd().format(
                                        DateTime.parse(data['date_added'])))),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: data['product_image'],
                                  width: 50,
                                  height: 100,
                                  fit: BoxFit.cover,
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
                                  (data['product_type'] == "nonVeg") ? 60 : 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (data['product_type']) == "nonVeg"
                                      ? Colors.red
                                      : Colors.green),
                              child: Center(
                                child: Text(
                                  (data['product_type'] == "nonVeg")
                                      ? "Non-Veg"
                                      : "Veg",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width:
                                  (data['product_type'] == "nonVeg") ? 30 : 60,
                            ),
                            Expanded(
                                child: Center(
                                    child: Text(data["product_category"]!))),
                            Expanded(
                                child: Center(
                                    child:
                                        Text("Rs ${data["product_price"]!}"))),
                          ]),
                        ),
                        onTap: () {
                          showGeneralDialog(
                              context: context,
                              transitionBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return SlideTransition(
                                  position: Tween(
                                          begin: const Offset(1, 0),
                                          end: const Offset(0, 0))
                                      .animate(animation),
                                  child: FadeTransition(
                                    opacity: CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut,
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return Align(
                                    alignment: Alignment.centerRight,
                                    child: MoreInfoPopup(
                                      image: data['product_image'],
                                      id: data['Id'],
                                      productName: data["product_name"]!,
                                      productDescription:
                                          data["product_description"]!,
                                      productType: data['product_type'],
                                      productAvailibility:
                                          data['product_availability'],
                                      productPrice: data["product_price"],
                                      productCategory: data['product_category'],
                                    ));
                              });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox(
              height: 200,
              width: 200,
              child: Center(child: CircularProgressIndicator()));
        }),
      )
    ]);
  }
}
