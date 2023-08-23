import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_page/moreinfo_dialog.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/screens/products/products_operation/create_operation/create_product_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart'; // for date format

class ProductsRead extends StatefulWidget {
  const ProductsRead({super.key});

  @override
  State<ProductsRead> createState() => _ProductsReadState();
}

class _ProductsReadState extends State<ProductsRead> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReadProductsBloc>(
      context,
    ).add(ReadInitialEvent(true));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(AppLocalizations.of(context)!.product_page_title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    minimumSize: const Size(88, 36),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {
                  showDialog(
                          context: context,
                          builder: (context) => const CreateProductForm())
                      .then((value) =>
                          BlocProvider.of<ReadProductsBloc>(context)
                              .add(ReadInitialEvent(false)));
                },
                child: Text(AppLocalizations.of(context)!.create_button)),
          ),
        ),
      ]),
      BlocBuilder<ReadProductsBloc, ReadProductsState>(
        builder: ((context, state) {
          if (state is ReadDataLoadedState) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.orange.shade600),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 80,
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.date_title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ))),
                      const SizedBox(width: 20),
                      SizedBox(
                          width: 60,
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.image_title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ))),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.product_name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          )),
                      SizedBox(
                          width: 80,
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.type_title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ))),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                          child: Center(
                              child: Text(
                        AppLocalizations.of(context)!.category_name_title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ))),
                      Expanded(
                          child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.price_title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height - 144,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 2,
                        color: Colors.grey.shade200,
                      );
                    },
                    itemCount: state.allProducts.length,
                    itemBuilder: (context, index) {
                      var data = state.allProducts[index];

                      return InkWell(
                        child: SizedBox(
                          height: 60,
                          child: Row(children: [
                            SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(DateFormat.MMMd().format(
                                        DateTime.parse(data.dateAdded)))),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: data.productImage,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      data.productName,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      data.productDescription.length > 75
                                          ? data.productDescription
                                                  .substring(0, 75) +
                                              '...'
                                          : data.productDescription,
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Center(
                                child: Container(
                                  height: 20,
                                  width:
                                      (data.productType == "nonVeg") ? 60 : 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: (data.productType) == "nonVeg"
                                          ? Colors.red
                                          : Colors.green),
                                  child: Center(
                                    child: Text(
                                      (data.productType == "nonVeg")
                                          ? AppLocalizations.of(context)!
                                              .non_veg_text
                                          : AppLocalizations.of(context)!
                                              .veg_text,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child:
                                    Center(child: Text(data.productCategory!))),
                            Expanded(
                                child: Center(
                                    child: Text("Rs ${data.productPrice!}"))),
                          ]),
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
                                      image: data.productImage,
                                      id: data.id,
                                      productName: data.productName!,
                                      productDescription:
                                          data.productDescription!,
                                      productType: data.productType,
                                      productAvailability:
                                          data.productAvailability,
                                      productPrice: data.productPrice,
                                      productCategory: data.productCategory,
                                    ));
                              });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox(
              height: 200,
              width: 200,
              child: Center(child: CircularProgressIndicator()));
        }),
      )
    ]);
  }
}
