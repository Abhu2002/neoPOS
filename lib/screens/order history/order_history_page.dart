import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/screens/order%20page/order_menu_page/total_order_checkout.dart';
import 'package:intl/intl.dart';
import '../../utils/common_text.dart';
import 'order_history_bloc.dart';
import 'widgets/common_card_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});
  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<String> filters = ['All','Daily', 'Weekly', 'Monthly'];
  var dropdownvalue = "";
  var f = NumberFormat("###,###", "en_US");
  var allOrders = [];

  @override
  void initState() {
    BlocProvider.of<OrderHistoryBloc>(context)
        .add(OrderHistoryPageInitEvent(true));
    super.initState();
    dropdownvalue = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CommonText20(
                text: AppLocalizations.of(context)!.order_history_page_title),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: filters.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                BlocProvider.of<OrderHistoryBloc>(context).add(OrderHistroyFilterEvent(dropdownvalue));
              },
            ),
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
                      child: CardOrderHistory(
                          id: AppLocalizations.of(context)!.order_history_id,
                          name: AppLocalizations.of(context)!.order_history_name,
                          mob: AppLocalizations.of(context)!.order_history_mob,
                          amt: AppLocalizations.of(context)!.order_history_amt,
                          date: AppLocalizations.of(context)!.date_title,
                          allOrders: allOrders)),

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
                      bool showORhideCheckoutBTN = false;
                       if (MediaQuery.of(context).size.width<850){
                          return Container();
                      } else{
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
                                  showORhideCheckoutbtn: showORhideCheckoutBTN)),
                        );
                      }

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
