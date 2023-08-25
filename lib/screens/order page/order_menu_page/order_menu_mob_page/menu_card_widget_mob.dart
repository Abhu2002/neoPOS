import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../navigation/route_paths.dart';
import '../../../products/products_page/moreinfo_dialog.dart';
import '../order_menu_bloc.dart';

class MenuCardMobWidget extends StatefulWidget {
  dynamic data;
  MenuCardMobWidget({Key? key, this.data}) : super(key: key);

  @override
  State<MenuCardMobWidget> createState() => _MenuCardMobWidgetState();
}

class _MenuCardMobWidgetState extends State<MenuCardMobWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.data == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, RoutePaths.dashboard);
      });
    }
  }

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

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey.shade100,
                height: MediaQuery.sizeOf(context).height * 0.68,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.allProds.length,
                  itemBuilder: (context, index) {
                    //var data = state.allProducts[index];
                    return InkWell(
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: prods[index]['product_image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(prods[index]['product_name']),
                            subtitle: Text(prods[index]['product_category']),
                            trailing: SizedBox(
                              width: 50,
                              height: 50,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: (prods[index]['product_type'] ==
                                                "nonVeg")
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                  Text(
                                      "Rs ${prods[index]['product_price'].toString()}"),
                                ],
                              ),
                            )),
                      ),
                      onTap: () {
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
                              return Align(
                                  alignment: Alignment.centerRight,
                                  child: MoreInfoPopup(
                                    image: prods[index]['product_image'],
                                    id: widget.data['Id'].toString(),
                                    productName: prods[index]['product_name'],
                                    productDescription: "",
                                    productType: prods[index]['product_type'],
                                    productAvailability: true,
                                    productPrice: prods[index]['product_price'],
                                    productCategory: prods[index]
                                        ['product_category'],
                                  ));
                            }).then((value) => BlocProvider.of<
                                OrderContentBloc>(context)
                            .add(
                                ProductLoadingEvent(widget.data['Id'], false)));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
