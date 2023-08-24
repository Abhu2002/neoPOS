import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_create_form.dart';

class ProductTypeSelect extends StatefulWidget {
  final ProductType? defaultType;
  final ProductType? stateType;
  final ValueChanged<ProductType?> onProductTypeChanged;

  const ProductTypeSelect(
      {super.key,
      required this.defaultType,
      required this.stateType,
      required this.onProductTypeChanged});

  @override
  State<ProductTypeSelect> createState() => _ProductTypeSelectState();
}

class _ProductTypeSelectState extends State<ProductTypeSelect> {
  @override
  Widget build(BuildContext context) {
    ProductType? defaultType = widget.defaultType;
    ProductType? stateType = widget.stateType;
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.product_type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Row(
            children: [
              Radio<ProductType>(
                value: ProductType.veg,
                groupValue: stateType ?? defaultType,
                onChanged: widget.onProductTypeChanged,
              ),
              Flexible(
                child: Text(AppLocalizations.of(context)!.veg),
              ),
              Radio<ProductType>(
                value: ProductType.nonVeg,
                groupValue: stateType ?? defaultType,
                onChanged: widget.onProductTypeChanged,
              ),
              Flexible(
                child: Text(AppLocalizations.of(context)!.non_veg),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
