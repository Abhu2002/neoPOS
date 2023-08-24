import 'package:flutter/material.dart';
import 'package:neopos/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';

class ProductName extends StatefulWidget {
  TextEditingController? productName;
  final ValueChanged<String> onProductNameChanged;
  ProductName({super.key, required this.productName, required this.onProductNameChanged});

  @override
  State<ProductName> createState() => _ProductNameState();
}

class _ProductNameState extends State<ProductName> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.productName,
      validator: (val) {
        if (!val.isValidProductName) {
          return AppLocalizations.of(context)!
              .valid_product_name;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText:
          AppLocalizations.of(context)!.product_name,
          prefixIcon: const Icon(
            Icons.restaurant_menu,
            color: AppColors.primaryColor,
          )),
      onChanged: widget.onProductNameChanged,
    );
  }
}
