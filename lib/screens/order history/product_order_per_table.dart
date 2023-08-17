import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_history_bloc.dart';

class ProductOrderPerTable extends StatefulWidget {
  const ProductOrderPerTable({super.key});

  @override
  State<ProductOrderPerTable> createState() => _ProductOrderPerTableState();
}

class _ProductOrderPerTableState extends State<ProductOrderPerTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        width: (MediaQuery.sizeOf(context).width / 2) - 80,
        height: (MediaQuery.sizeOf(context).height) * 0.87,
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoaded || state is ShowProductsState) {
              var productList = state.productList;
              var data = state.allOrder;
              var showORhide = false;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 10, 8),
                                        child: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<OrderHistoryBloc>(
                                                      context)
                                                  .add(ShowOrderProductsEvent(
                                                      '0', data, showORhide));
                                            },
                                            icon: const Icon(
                                              Icons.close_sharp,
                                              color: Colors.black87,
                                            ))),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text("Order ID : #${state.orderId}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        //height:300,
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: productList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 20, 10, 10),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${productList[index]["productName"]}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20)),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Category :${productList[index]["productCategory"]}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Price: ${productList[index]["productPrice"]}"),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          8,
                                                                          8,
                                                                          8),
                                                              child: Text(
                                                                  "Quantity ${productList[index]["quantity"]}"))
                                                        ],
                                                      )
                                                    ]),
                                              )),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "Total: ${int.parse(state.productList[index]["productPrice"]) * int.parse(state.productList[index]["quantity"])}"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, top: 25),
                                    child: Text(
                                      "Items(${state.productList.length})",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 25, top: 25),
                                    child: Text(
                                      "₹${state.amount}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 25, top: 15, bottom: 10),
                                    child: Text(
                                      "GST (${5}%)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 25, top: 15, bottom: 10),
                                    child: Text(
                                      "₹${state.amount * 0.05}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: Divider(
                                  height: 2,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 25, top: 25),
                                    child: Text(
                                      "Total",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 25, top: 25),
                                    child: Text(
                                      "₹${(state.amount + state.amount * 0.05).round()}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
