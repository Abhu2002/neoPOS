import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../moreinfo_dialog.dart';

class ProductTable extends StatefulWidget {
  dynamic data;

  ProductTable({super.key, this.data});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
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
                  padding: const EdgeInsets.only(left:20.0),
                  child: Text(
                    data.productName,
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
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
                width: (data.productType == "nonVeg") ? 60 : 30,
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
                        : AppLocalizations.of(context)!.veg_text,
                    style: const TextStyle(color: Colors.white),
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
  }
}
