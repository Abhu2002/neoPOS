import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/screens/order%20history/product_order_per_table.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'order_history_bloc.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(OrderHistoryPageInitEvent(true));
    super.initState();
  }

  var f = NumberFormat("###,###", "en_US");
  var allOrders = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(AppLocalizations.of(context)!.order_history_page_title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ]),
        BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            // print(state);
            if (state is OrderHistoryLoaded || state is ShowProductsState) {
              // return Text("${state.allOrder.docs[0]["amount"]}");
              allOrders = state.allOrder;
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height - 119,
                      child: ListView.builder(
                        itemCount: state.allOrder.length,
                        itemBuilder: (context, index) {
                          var data = state.allOrder[index];

                          return InkWell(
                            onTap: () {
                              BlocProvider.of<OrderHistoryBloc>(context).add(
                                  ShowOrderProductsEvent(
                                      data["Id"], allOrders));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              borderOnForeground: true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 80,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    "Order Id: ${data["Id"]}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    DateFormat('MMM dd hh:mm')
                                                        .format(DateTime.parse(
                                                            data[
                                                                'order_date'])),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .subTextColor),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        /*  Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["table_name"],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),*/
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(children: [
                                            Expanded(
                                                flex: 5,
                                                child: Text(
                                                  "Mode: ${data["payment_mode"]}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "₹${f.format(data["amount"])}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ]),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: ProductOrderPerTable(),
                  ), //--->widget end
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ]),
    );
  }
}
