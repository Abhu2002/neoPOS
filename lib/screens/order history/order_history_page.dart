import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/screens/order%20page/order_menu_page/total_order_checkout.dart';
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
            if (state is OrderHistoryLoaded || state is ShowProductsState) {
              allOrders = state.allOrder;
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: (MediaQuery.sizeOf(context).height) * 0.82,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.orange.shade600,
                              height: 50,
                              child: const Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                        width: 20,
                                        child: Center(
                                            child: Text(
                                          "Id",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                        width: 80,
                                        child: Center(
                                            child: Text(
                                          "Customer Name",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                        width: 80,
                                        child: Center(
                                            child: Text(
                                          "Moblie no",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                        width: 80,
                                        child: Center(
                                            child: Text(
                                          "Amount",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                        width: 50,
                                        child: Center(
                                            child: Text(
                                          "Date",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.70,
                              child: ListView.separated(
                                itemCount: allOrders.length,
                                separatorBuilder: (context, index) {
                                  return Container(
                                    height: 1,
                                    color: Colors.grey,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  var data = allOrders[index];
                                  var showORhide = true;

                                  return InkWell(
                                    onTap: () {
                                      BlocProvider.of<OrderHistoryBloc>(context)
                                          .add(ShowOrderProductsEvent(
                                              data["Id"],
                                              allOrders,
                                              showORhide));
                                    },
                                    child: Container(
                                      height: 50,
                                      color: (state.orderId ==
                                              (index + 1).toString())
                                          ? AppColors.primarySwatch.shade50
                                          : Colors.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 20,
                                                child: Center(
                                                    child:
                                                        Text("${data["Id"]}")),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                child: Center(
                                                    child: Text(
                                                        "${data["customer_name"]}")),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                child: Center(
                                                    child: Text(
                                                        "${data["customer_mobile_no"]}")),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                child: Center(
                                                    child: Text(
                                                        "₹${data["amount"]}")),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                child: Center(
                                                    child: Text(DateFormat
                                                            .MMMd()
                                                        .format(DateTime.parse(
                                                            data[
                                                                "order_date"])))),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
                      builder: ((context, state) {
                    if (state is OrderHistoryLoaded ||
                        state is ShowProductsState) {
                      var products = state.productList;
                      var data = state.allOrder;
                      bool showORhide = false;
                      double amount = state.amount;
                      String orderID = state.orderId;
                      bool showORhideMinus = false;
                      bool showORhideAdd = false;
                      bool showORhideBin = false;
                      bool showORhideCheckoutbtn = false;
                      return Visibility(
                        visible: state.showORhide,
                        child: Expanded(
                            flex: 3,
                            child: TotalOrderCheckout(
                                showORhide: showORhide,
                                data: data,
                                products: products,
                                totalPrice: amount,
                                orderID: orderID,
                                showORhideAdd: showORhideAdd,
                                showORhideBin: showORhideBin,
                                showORhideMinus: showORhideMinus,
                                showORhideCheckoutbtn: showORhideCheckoutbtn)),
                      );
                    } else {
                      return Container();
                    }
                  })) //--->widget end
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
