import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';

import '../../../utils/app_colors.dart';
import '../products_operation/delete_operation/delete_product_dialog.dart';
import '../products_operation/update_operation/product_update_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreInfoPopup extends StatefulWidget {
  const MoreInfoPopup(
      {super.key,
      required this.image,
      required this.id,
      required this.productName,
      required this.productDescription,
      required this.productType,
      required this.productAvailibility,
      required this.productPrice,
      required this.productCategory});

  final String image;
  final String id;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productType;
  final bool productAvailibility;
  final int productPrice;

  @override
  State<MoreInfoPopup> createState() => _MoreInfoPopupState();
}

class _MoreInfoPopupState extends State<MoreInfoPopup> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0, -0.5),
              colors: <Color>[
                Color.fromRGBO(222, 180, 139, 1.0),
                Color.fromRGBO(245, 245, 245, 1),
              ],
            ),
          ),
          height: MediaQuery.sizeOf(context).height,
          width: 400,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(AppLocalizations.of(context)!.product_details,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.mainTextColor,
                      size: 30,
                    ),
                    label: const Text(""),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                          imageUrl: widget.image,
                          width: 250,
                          height: 200,
                          fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 155,
                      child: Text(
                          AppLocalizations.of(context)!.product_name_title,
                          style: const TextStyle(
                              color: AppColors.mainTextColor, fontSize: 18)),
                    ),
                    Text(widget.productName,
                        style: const TextStyle(fontSize: 18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 155,
                      child: Text(
                        AppLocalizations.of(context)!.product_description_title,
                        style: const TextStyle(
                            color: AppColors.mainTextColor, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                        width: 150,
                        child: Text(widget.productDescription,
                            softWrap: true,
                            style: const TextStyle(fontSize: 18)))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 155,
                      child: Text(
                        AppLocalizations.of(context)!.product_category_title,
                        style: const TextStyle(
                            color: AppColors.mainTextColor, fontSize: 18),
                      ),
                    ),
                    Text(widget.productCategory,
                        style: const TextStyle(fontSize: 18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 155,
                      child: Text(
                        AppLocalizations.of(context)!.type_title,
                        style: const TextStyle(
                            color: AppColors.mainTextColor, fontSize: 18),
                      ),
                    ),
                    // Text(element["product_type"]!,style: TextStyle(fontSize: 18))
                    Container(
                      height: 20,
                      width: (widget.productType == "nonVeg") ? 60 : 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (widget.productType) == "nonVeg"
                              ? Colors.red
                              : Colors.green),
                      child: Center(
                        child: Text(
                          (widget.productType == "nonVeg")
                              ? AppLocalizations.of(context)!.non_veg_text
                              : AppLocalizations.of(context)!.veg_text,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 158,
                      child: Text(
                        AppLocalizations.of(context)!
                            .product_availability_title,
                        style: const TextStyle(
                            color: AppColors.mainTextColor, fontSize: 18),
                      ),
                    ),
                    Icon(
                      size: 30,
                      (widget.productAvailibility) == true
                          ? Icons.check
                          : Icons.cancel,
                      color: (widget.productAvailibility) == true
                          ? Colors.green
                          : Colors.red,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30, left: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        AppLocalizations.of(context)!.product_price,
                        style: const TextStyle(
                            color: AppColors.mainTextColor, fontSize: 18),
                      ),
                    ),
                    Text((widget.productPrice).toString(),
                        style: const TextStyle(fontSize: 18))
                  ],
                ),
              ),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return UpdateProductDialog(
                            image: widget.image,
                            id: widget.id,
                            productName: widget.productName,
                            productDescription: widget.productDescription,
                            productType: widget.productType,
                            productAvailibility: widget.productAvailibility,
                            productPrice: widget.productPrice,
                            productCategory: widget.productCategory,
                          );
                        },
                      ).then((value) {
                        Navigator.of(context).pop();
                        BlocProvider.of<ReadProductsBloc>(context)
                            .add(ReadInitialEvent(false));
                      });
                    },
                    child:
                        Text(AppLocalizations.of(context)!.edit_product_button),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteProductPopup(productID: widget.id);
                          }).then((value) => {
                            Navigator.pop(context),
                            BlocProvider.of<ReadProductsBloc>(
                              context,
                            ).add(ReadInitialEvent(false))
                          });
                    },
                    child: Text(
                        AppLocalizations.of(context)!.delete_product_button),
                  ),
                ],
              )),
            ]),
          )),
    );
  }
}
