import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/order%20page/order_page/order_content_page/order_content_bloc.dart';
import 'package:neopos/screens/order%20page/order_page/order_content_page/order_content_event.dart';
import 'package:neopos/screens/order%20page/order_page/order_content_page/order_content_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';

class OrderMenuPage extends StatefulWidget {
  const OrderMenuPage({Key? key}) : super(key: key);

  @override
  State<OrderMenuPage> createState() => _OrderMenuPageState();
}

class _OrderMenuPageState extends State<OrderMenuPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrderContentBloc>(context).add(ProductLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Menu",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              BlocBuilder<OrderContentBloc, OrderContentState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height - 174,
                          child: ListView.separated(
                            //shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: 2,
                                color: Colors.grey.shade200,
                              );
                            },
                            itemCount: state.allProds.length,
                            itemBuilder: (context, index) {
                              var data = state.allProds[index];
                              if (index == 0) {
                                // return the header
                                return Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 50,
                                  decoration:
                                  BoxDecoration(color: Colors.grey.shade300),
                                  child: Row(
                                    children: [

                                      Container(
                                          width: 100,
                                          child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!.image_title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: AppColors.primaryColor),
                                              ))),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .product_name_title,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: AppColors.primaryColor),
                                          )),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Container(
                                          width: 60,
                                          child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!.type_title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: AppColors.primaryColor),
                                              ))),
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .category_name_title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: AppColors.primaryColor),
                                              ))),
                                      Expanded(
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.price_title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: AppColors.primaryColor),
                                            ),
                                          )),
                                      // Text("More"),
                                    ],
                                  ),
                                );
                              }

                              return InkWell(
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: CachedNetworkImage(
                                            imageUrl: data['product_image'],
                                            width: 20,
                                            height: 30,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 80,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['product_name'],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      height: 20,
                                      width:
                                      (data['product_type'] == "nonVeg") ? 60 : 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: (data['product_type']) == "nonVeg"
                                              ? Colors.red
                                              : Colors.green),
                                      child: Center(
                                        child: Text(
                                          (data['product_type'] == "nonVeg")
                                              ? AppLocalizations.of(context)!
                                              .non_veg_text
                                              : AppLocalizations.of(context)!.veg_text,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      (data['product_type'] == "nonVeg") ? 30 : 60,
                                    ),
                                    Expanded(
                                        child: Center(
                                            child: Text(data["product_category"]!))),
                                    Expanded(
                                        child: Center(
                                            child:
                                            Text("Rs ${data["product_price"]!}"))),
                                  ]),
                                ),
                                onTap: () {

                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
