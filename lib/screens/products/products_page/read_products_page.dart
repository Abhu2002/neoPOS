import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_page/moreinfo_dialog.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';
import 'package:neopos/utils/app_colors.dart';

import '../../../utils/popup_cancel_button.dart';

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

                  columns: const [
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Image")),
                    DataColumn(label: Flexible(child: Text('Product Name'))),
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("Category")),
                    DataColumn(label: Flexible(child: Text('Price'))),
                    // DataColumn(
                    //     label: Flexible(child: Text('Product Available'))),
                    DataColumn(label: Flexible(child: Text('More Details'))),
                  ],
                  rows: state
                      .allProducts // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                //Extracting from Map element the value
                                DataCell(Text("1 Aug")),
                                DataCell(Container(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    element['product_image'],
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                                ))),
                                DataCell(Text(element["product_name"]!)),
                                DataCell(Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          (element['product_type']) == "Non-veg"
                                              ? Colors.red
                                              : Colors.green),
                                )),
                                DataCell(Text(element["product_category"]!)),
                                DataCell(Text("${element["product_price"]!}")),
                                // DataCell(Text(
                                //     "${element["product_availability"]!}")),

                                DataCell(Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0),
                                          onPressed: () async {
                                            showAlignedDialog(
                                                context: context,
                                                builder: (context) {
                                                  return MoreInfoPopup(
                                                      image: element[
                                                          'product_image'],
                                                      productName: element[
                                                          "product_name"]!,
                                                      productDescription: element[
                                                          "product_description"]!,
                                                      productType: element[
                                                          'product_type'],
                                                      productAvailibility: element[
                                                          'product_availability'],
                                                      productPrice: element[
                                                          "product_price"],productCategory:  element[
                                                  'product_category'],);
                                                },
                                                followerAnchor:
                                                    Alignment.centerRight,
                                                targetAnchor:
                                                    Alignment.centerRight,
                                                isGlobal: true,
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
                                                        Animation<double>
                                                            secondaryAnimation,
                                                        Widget child) {
                                                  return SlideTransition(
                                                    position: Tween(
                                                            begin: Offset(1, 0),
                                                            end: Offset(0, 0))
                                                        .animate(animation),
                                                    child: FadeTransition(
                                                      opacity: CurvedAnimation(
                                                        parent: animation,
                                                        curve: Curves.easeOut,
                                                      ),
                                                      child: child,
                                                    ),
                                                  );
                                                });
                                          },
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
              );
            } else if (state is ReadDataLoadingState) {
              return Text("Loading");
            } else if (state is ReadErrorState) {
              return Text(state.errorMessage);
            }
            return Text("");
          },
        ),
      ),
    ]);
  }
}
