import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/order%20page/order_menu_page/total_order_checkout.dart';
import 'package:neopos/screens/order%20page/widgets/order_checkout_popup.dart';
import '../../../navigation/route_paths.dart';
import '../widgets/menu_btns_widget.dart';
import '../widgets/menu_cards_widget.dart';
import 'order_menu_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderMenuPage extends StatefulWidget {
  dynamic data;

  OrderMenuPage({Key? key, this.data}) : super(key: key);

  @override
  State<OrderMenuPage> createState() => _OrderMenuPageState();
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  @override
  void initState() {
    super.initState();
    if (widget.data != null && widget.data.containsKey('Id')) {
      BlocProvider.of<OrderContentBloc>(context)
          .add(ProductLoadingEvent(widget.data['Id'].toString(), false));
    } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, RoutePaths.dashboard);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 100),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  MenuBtnsWidget(data: widget.data),
                  Expanded(
                    flex: 5,
                    child: MenuCardWidget(
                      data: widget.data,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<OrderContentBloc, OrderContentState>(
              builder: (context, state) {
            if (state is ProductLoadingState || state is FilterProductsState) {
              final products = state.products;
              totalPrice = 0.0;
              var showORhide = state.showORhide;
              for (final product in products) {
                double productPrice = double.parse(product.productPrice);
                int productQuantity = int.parse(product.quantity);

                totalPrice += productPrice * productQuantity;
              } // Reset the total price
              bool showORhideMinus = true;
              bool showORhideAdd = true;
              bool showORhideBin = true;
              bool showORhideCheckoutbtn = true;
              return Visibility(
                visible: state.showORhide,
                child: Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TotalOrderCheckout(
                      showORhide: showORhide,
                      data: widget.data,
                      products: state.products,
                      totalPrice: totalPrice,
                      showORhideAdd: showORhideAdd,
                      showORhideBin: showORhideBin,
                      showORhideMinus: showORhideMinus,
                      showORhideCheckoutbtn: showORhideCheckoutbtn,
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}
