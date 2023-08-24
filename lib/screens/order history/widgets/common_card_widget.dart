import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neopos/screens/order%20page/order_menu_page/total_order_checkout.dart';
import 'package:neopos/utils/common_text.dart';
import '../../../utils/app_colors.dart';
import '../order_history_bloc.dart';

class CardOrderHistory extends StatefulWidget {
  final String id;
  final String name;
  final String mob;
  final String amt;
  final String date;
  final List allOrders;
  const CardOrderHistory(
      {Key? key,
      required this.id,
      required this.name,
      required this.mob,
      required this.amt,
      required this.date,
      required this.allOrders})
      : super(key: key);

  @override
  State<CardOrderHistory> createState() => _CardOrderHistoryState();
}

class _CardOrderHistoryState extends State<CardOrderHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: (MediaQuery.sizeOf(context).height) * 0.82,
            child: Column(
              children: [
                Container(
                  color: Colors.orange.shade600,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: 20,
                            child:
                                Center(child: CommonText15(text: widget.id))),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                            width: 80,
                            child:
                                Center(child: CommonText15(text: widget.name))),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                            width: 80,
                            child:
                                Center(child: CommonText15(text: widget.mob))),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: 80,
                            child:
                                Center(child: CommonText15(text: widget.amt))),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: 50,
                            child:
                                Center(child: CommonText15(text: widget.date))),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.70,
                  child: ListView.separated(
                    itemCount: widget.allOrders.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      );
                    },
                    itemBuilder: (context, index) {
                      var newindex = index + int.parse(widget.allOrders[0]["Id"]!);
                      var data = widget.allOrders[index];
                      var showORhide = true;
                      return InkWell(
                        onTap: () {
                          if (MediaQuery.of(context).size.width < 850) {
                            BlocProvider.of<OrderHistoryBloc>(context).add(
                                ShowOrderProductsEvent(
                                    data["Id"], widget.allOrders, showORhide));
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
                                  return BlocBuilder<OrderHistoryBloc,
                                      OrderHistoryState>(
                                    builder: (context, state) {
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
                                        bool showORhideCheckoutBTN = false;

                                        return Align(
                                            alignment: Alignment.centerRight,
                                            child: Material(
                                              child: TotalOrderCheckout(
                                                  showORhide: showORhide,
                                                  data: data,
                                                  products: products,
                                                  totalPrice: amount,
                                                  orderID: orderID,
                                                  showORhideAdd: showORhideAdd,
                                                  showORhideBin: showORhideBin,
                                                  showORhideMinus:
                                                      showORhideMinus,
                                                  showORhideCheckoutbtn:
                                                      showORhideCheckoutBTN),
                                            ));
                                      }
                                      else{
                                        return Container();
                                      }
                                    },
                                  );
                                });
                          } else {
                            BlocProvider.of<OrderHistoryBloc>(context).add(
                                ShowOrderProductsEvent(
                                    data["Id"], widget.allOrders, showORhide));
                          }
                        },
                        child: Container(
                          height: 50,
                          color: (state.orderId == (newindex).toString())
                              ? AppColors.primarySwatch.shade50
                              : Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 20,
                                    child: Center(child: Text("${data["Id"]}")),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: SizedBox(
                                    child: Center(
                                        child:
                                            Text("${data["customer_name"]}")),
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
                                        child: Text("₹${data["amount"]}")),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    child: Center(
                                        child: Text(DateFormat.MMMd().format(
                                            DateTime.parse(
                                                data["order_date"])))),
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
        );
      },
    );
  }
}
