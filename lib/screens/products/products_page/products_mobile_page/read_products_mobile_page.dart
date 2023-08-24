import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../products_operation/create_operation/create_product_dialog.dart';
import '../moreinfo_dialog.dart';
import '../read_products_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductMobileRead extends StatefulWidget {
  const ProductMobileRead({super.key});

  @override
  State<ProductMobileRead> createState() => _ProductMobileReadState();
}

class _ProductMobileReadState extends State<ProductMobileRead> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReadProductsBloc>(context).add(ReadInitialEvent(true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadProductsBloc, ReadProductsState>(
      builder: (context, state) {
        if (state is ReadDataLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: SizedBox(
                  height: 40,
                  child: Text(AppLocalizations.of(context)!.product_page_title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                color: Colors.grey.shade100,
                height: MediaQuery.sizeOf(context).height * 0.83,
                child: Stack(alignment: Alignment.bottomRight, children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.allProducts.length,
                    itemBuilder: (context, index) {
                      var data = state.allProducts[index];
                      return InkWell(
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: data.productImage,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(data.productName),
                              subtitle: Text(
                                data.productDescription.length > 75
                                    ? data.productDescription.substring(0, 75) +
                                        '...'
                                    : data.productDescription,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
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
                                          color: (data.productType) == "nonVeg"
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                    Text("Rs ${data.productPrice!}"),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (context) => const CreateProductForm())
                            .then((value) =>
                                BlocProvider.of<ReadProductsBloc>(context)
                                    .add(ReadInitialEvent(false)));
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ]),
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
