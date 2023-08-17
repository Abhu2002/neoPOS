import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/order%20page/widgets/order_checkout_popup.dart';
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
          .add(ProductLoadingEvent(widget.data['Id'].toString()));
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
                    flex: 8,
                    child: MenuCardWidget(
                      data: widget.data,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.order,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                        child: BlocBuilder<OrderContentBloc, OrderContentState>(
                          builder: (BuildContext context, state) {
                            if (state is ProductLoadingState ||
                                state is FilterProductsState) {
                              final products = state.products;
                              totalPrice = 0.0; // Reset the total price
                              for (final product in products) {
                                double productPrice =
                                double.parse(product.productPrice);
                                int productQuantity = int.parse(product.quantity);

                                totalPrice += productPrice * productQuantity;
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height * 0.57,
                                    child: ListView.builder(
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        final product = products[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Card(
                                            elevation: 3,
                                            color: Colors.grey.shade50,
                                            child: ListTile(
                                              title: Text(product.productName),
                                              subtitle:
                                              Text(product.productCategory),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.remove),
                                                    onPressed: () {
                                                      //Logic to decrease quantity
                                                      if (int.parse(product.quantity) > 1) {
                                                        BlocProvider.of<OrderContentBloc>(context).add(
                                                          DecreaseQuantityEvent(index, widget.data['Id'].toString(), int.parse(product.quantity)-1),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Text('${product.quantity} x ₹${product.productPrice}'),
                                                  IconButton(
                                                    icon: const Icon(Icons.add),
                                                    onPressed: () {
                                                      // Logic to increase quantity
                                                      BlocProvider.of<OrderContentBloc>(context).add(
                                                        IncreaseQuantityEvent(index, widget.data['Id'].toString(), int.parse(product.quantity)+1),
                                                      );
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(Icons.delete),
                                                    onPressed: () {
                                                      // Logic to delete order
                                                      BlocProvider.of<OrderContentBloc>(context).add(
                                                        DeleteOrderEvent(index, widget.data['Id'].toString()),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.3,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25, top: 25),
                                                child: Text(
                                                  "Items(${state.products.length})",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25, top: 25),
                                                child: Text(
                                                  "₹$totalPrice",
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
                                                  "₹${totalPrice * 0.05}",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, right: 25),
                                            child: Divider(
                                              height: 2,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25, top: 25),
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
                                                  "₹${(totalPrice + totalPrice * 0.05).round()}",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5))),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CheckOutPopUp(totalPrice: totalPrice.toInt(),id: widget.data['Id']);
                                                  });
                                            },
                                            child: const Text('Checkout'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is ErrorState) {
                              return Center(
                                  child: Center(child: Text(state.errorMessage)));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

