import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../products_operation/create_operation/create_product_dialog.dart';
import '../read_products_bloc.dart';

class ProductReadHead extends StatefulWidget {
  const ProductReadHead({super.key});

  @override
  State<ProductReadHead> createState() => _ProductReadHeadState();
}

class _ProductReadHeadState extends State<ProductReadHead> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(AppLocalizations.of(context)!.product_page_title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    .then((value) => BlocProvider.of<ReadProductsBloc>(context)
                        .add(ReadInitialEvent(false)));
              },
              child: Text(AppLocalizations.of(context)!.create_button)),
        ),
      ),
    ]);
  }
}
