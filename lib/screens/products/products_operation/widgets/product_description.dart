import 'package:flutter/material.dart';
import 'package:neopos/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';

class ProductDescription extends StatefulWidget {
  TextEditingController? controller;
  ProductDescription({super.key, this.controller});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 2,
        decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!
                .product_description_title,
            prefixIcon: const Icon(
              Icons.description,
              color: AppColors.primaryColor,
            )),
        validator: (val) {
          if (!val.isValidDesc) {
            return AppLocalizations.of(context)!.valid_description;
          } else {
            return null;
          }
        });
  }
}
