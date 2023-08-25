import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_create_form.dart';
import '../create_operation/create_product_bloc.dart';

class CategoryDropDown extends StatefulWidget {
  final List categories;
  final String? dropdownvalue;
  final ValueChanged<String> onCategoryChanged;

  const CategoryDropDown(
      {required this.categories,
      super.key,
      this.dropdownvalue,
      required this.onCategoryChanged});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductBloc, CreateProductState>(
      builder: (BuildContext context, state) {
        return DropdownButton(
          alignment: Alignment.centerLeft,
          value: state.category ?? widget.dropdownvalue,
          items: widget.categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (newValue) {
            BlocProvider.of<CreateProductBloc>(context)
                .add(CategoryChangedEvent(newValue.toString()));
            widget.onCategoryChanged(newValue.toString());
            categoryValue = newValue.toString();
          },
        );
      },
    );
  }
}
