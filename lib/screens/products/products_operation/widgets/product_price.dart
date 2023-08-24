import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/utils/utils.dart';
import '../../../../utils/app_colors.dart';

class ProductPrice extends StatefulWidget {
  TextEditingController? controller;
  ProductPrice({super.key, required this.controller});

  @override
  State<ProductPrice> createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.product_price,
          prefixIcon: const Icon(
            Icons.price_check,
            color: AppColors.primaryColor,
          )),
      keyboardType: TextInputType.number,
      validator: (val) {
        if (!val.isValidPrice) {
          return AppLocalizations.of(context)!.valid_price;
        } else {
          return null;
        }
      },
    );
  }
}
