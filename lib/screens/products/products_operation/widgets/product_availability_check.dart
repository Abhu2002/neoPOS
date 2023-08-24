import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductAvailabilityCheck extends StatefulWidget {
  bool isChecked;
  ValueChanged<bool?> onAvailabilityChanged;
  ProductAvailabilityCheck({super.key, required this.isChecked, required this.onAvailabilityChanged});

  @override
  State<ProductAvailabilityCheck> createState() => _ProductAvailabilityCheckState();
}

class _ProductAvailabilityCheckState extends State<ProductAvailabilityCheck> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.product_available,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Checkbox(
          value: widget.isChecked,
          onChanged: widget.onAvailabilityChanged,
        ),
      ],
    );
  }
}
