import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_create_form.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'create_product_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class CreateProductForm extends StatefulWidget {
  const CreateProductForm({super.key});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        actionsPadding: const EdgeInsets.all(20),
        title: PopUpRow(title: AppLocalizations.of(context)!.create_product),
        actions: [
          BlocListener<CreateProductBloc, CreateProductState>(
            listener: (context, state) {
              if (state is ProductNameNotAvailableState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      actionsPadding: const EdgeInsets.all(20),
                      actions: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.pro_name_exist,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CreateProductBloc>(context)
                                      .add(NameNotAvaiableEvent());
                                  Navigator.pop(context);
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.ok_button)),
                          ],
                        )
                      ],
                    );
                  },
                );
              }
            },
            child: const Text(""),
          ),
          const ProductCreateForm(),
        ],
      ),
    );
  }
}
