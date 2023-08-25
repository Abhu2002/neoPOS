import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_operation/widgets/product_create_form.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/utils/popup_cancel_button.dart';
import 'create_product_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class CreateProductMobileForm extends StatefulWidget {
  const CreateProductMobileForm({super.key});

  @override
  State<CreateProductMobileForm> createState() =>
      _CreateProductMobileFormState();
}

class _CreateProductMobileFormState extends State<CreateProductMobileForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                PopUpRow(title: AppLocalizations.of(context)!.create_product),
                BlocListener<CreateProductBloc, CreateProductState>(
                  listener: (context, state) {
                    if (state is ProductNameNotAvailableState) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            actionsPadding: const EdgeInsets.all(20),
                            actions: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .pro_name_exist,
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
                                        BlocProvider.of<CreateProductBloc>(
                                                context)
                                            .add(NameNotAvaiableEvent());
                                        Navigator.pop(context);
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .ok_button)),
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
                const ProductCreateForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
