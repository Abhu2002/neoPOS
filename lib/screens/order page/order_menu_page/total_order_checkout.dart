import 'package:flutter/material.dart';
import '../../order history/order_history_bloc.dart';
import '../widgets/order_checkout_popup.dart';
import 'order_menu_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TotalOrderCheckout extends StatefulWidget {
  TotalOrderCheckout(
      {super.key,
      required this.showORhide,
      required this.data,
      required this.products,
      required this.totalPrice,
      this.orderID = '',
      required this.showORhideAdd,
      required this.showORhideBin,
      required this.showORhideMinus,
      required this.showORhideCheckoutbtn});

  dynamic data;
  String orderID;
  var products;
  bool showORhide;
  bool showORhideAdd;
  bool showORhideBin;
  bool showORhideCheckoutbtn;
  bool showORhideMinus;
  double totalPrice;

  @override
  State<TotalOrderCheckout> createState() => _TotalOrderCheckoutState();
}

class _TotalOrderCheckoutState extends State<TotalOrderCheckout> {
  var productname;

  var productquantity;

  var productcategory;

  var productprice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
                  child: IconButton(
                      onPressed: () {
                        if (widget.showORhideAdd == true) {
                          widget.showORhide = false;
                          BlocProvider.of<OrderContentBloc>(context).add(
                              ProductLoadingEvent(widget.data['Id'].toString(),
                                  widget.showORhide));
                        } else {
                          BlocProvider.of<OrderHistoryBloc>(context).add(
                              ShowOrderProductsEvent(
                                  '0', widget.data, widget.showORhide));
                        }
                      },
                      icon: const Icon(
                        Icons.close_sharp,
                        color: Colors.black87,
                      ))),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.order + " ",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(widget.orderID,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    if (widget.showORhideMinus == false) {
                      productname = product['productName'];
                      productcategory = product['productCategory'];
                      productquantity = product['quantity'];
                      productprice = product['productPrice'];
                    } else {
                      productname = product.productName;
                      productcategory = product.productCategory;
                      productquantity = product.quantity;
                      productprice = product.productPrice;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 3,
                        color: Colors.grey.shade50,
                        child: ListTile(
                          title: Text(productname),
                          subtitle: Text(productcategory),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: widget.showORhideMinus,
                                child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    //Logic to decrease quantity
                                    if (int.parse(productquantity) > 1) {
                                      BlocProvider.of<OrderContentBloc>(context)
                                          .add(
                                        DecreaseQuantityEvent(
                                            index,
                                            widget.data['Id'].toString(),
                                            int.parse(productquantity) - 1),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Text('$productquantity x ₹$productprice'),
                              Visibility(
                                visible: widget.showORhideAdd,
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    // Logic to increase quantity
                                    BlocProvider.of<OrderContentBloc>(context)
                                        .add(
                                      IncreaseQuantityEvent(
                                          index,
                                          widget.data['Id'].toString(),
                                          int.parse(product.quantity) + 1),
                                    );
                                  },
                                ),
                              ),
                              Visibility(
                                visible: widget.showORhideBin,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Logic to delete order
                                    BlocProvider.of<OrderContentBloc>(context)
                                        .add(
                                      DeleteOrderEvent(
                                          index, widget.data['Id'].toString()),
                                    );
                                  },
                                ),
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
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, top: 25),
                            child: Text(
                              "Items(${widget.products.length})",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 25),
                            child: Text(
                              "₹${widget.totalPrice}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 25, top: 15, bottom: 10),
                            child: Text(
                              "GST (${5}%)",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 25, top: 15, bottom: 10),
                            child: Text(
                              "₹${widget.totalPrice * 0.05}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 25, top: 25),
                            child: Text(
                              "₹${(widget.totalPrice + widget.totalPrice * 0.05).round()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: widget.showORhideCheckoutbtn,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CheckOutPopUp(
                                      totalPrice: widget.totalPrice.toInt(),
                                      id: widget.data['Id']);
                                });
                          },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
