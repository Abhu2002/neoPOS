import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<ReadProductsBloc, ReadProductsState>(
          builder: (context, state) {
            if (state is ReadDataLoadedState) {
              return SizedBox(
                // width: MediaQuery.sizeOf(context).width,
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
                    DataColumn(label: Flexible(child: Text('Available'))),
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
                                DataCell(
                                    (element["product_availability"] == true)
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.red,
                                          )
                                    // Text("${element["product_availability"]!}")
                                    ),

                                DataCell(Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
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
