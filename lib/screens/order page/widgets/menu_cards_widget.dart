import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../order_menu_page/order_menu_bloc.dart';
import 'add_order.dart';

class MenuCardWidget extends StatefulWidget {
  dynamic data;
  MenuCardWidget({Key? key, this.data}) : super(key: key);

  @override
  State<MenuCardWidget> createState() => _MenuCardWidgetState();
}

class _MenuCardWidgetState extends State<MenuCardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderContentBloc, OrderContentState>(
      builder: (context, state) {
        if (state is ProductLoadingState || state is FilterProductsState) {
          var prods = state.allProds;

          if (prods.isEmpty) {
            return Text(
              "No products found in ${state.category}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 200 / 250,
              ),
              itemCount: state.allProds.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    elevation: 10.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: 170,
                            child: CachedNetworkImage(
                              imageUrl: prods[index]['product_image'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 100.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 5.0,
                          ),
                          child: Text(
                            prods[index]['product_name'],
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 5.0,
                          ),
                          child: Text(
                            "Rs. ${prods[index]['product_price'].toString()}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  prods[index]
                                  ['product_category'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color:
                                      prods[index]['product_type'] == "nonVeg"
                                          ? Colors.red
                                          : Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      prods[index]['product_type'] == "nonVeg"
                                          ? "Non-Veg"
                                          : "Veg",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddOrder(
                          productName: prods[index]['product_name'],
                          productCategory: prods[index]['product_category'],
                          productType: prods[index]['product_type'],
                          productPrice:
                              prods[index]['product_price'].toString(),
                          docId: widget.data['Id'].toString(),
                        );
                      },
                    ).then((value) => BlocProvider.of<OrderContentBloc>(context)
                        .add(ProductLoadingEvent(widget.data['Id'])));
                  },
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
