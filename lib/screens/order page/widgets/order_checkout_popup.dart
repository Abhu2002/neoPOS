import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/navigation/route_paths.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/popup_cancel_button.dart';
import '../order_menu_page/order_menu_bloc.dart';

class CheckOutPopUp extends StatefulWidget {
  const CheckOutPopUp({super.key, required this.totalPrice, required this.id});
  final int totalPrice;
  final String id;
  @override
  State<CheckOutPopUp> createState() => _CheckOutPopUpState();
}

enum SingingCharacter { cash, card, upi }

class _CheckOutPopUpState extends State<CheckOutPopUp> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SingingCharacter? _character = SingingCharacter.cash;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      title: const PopUpRow(
        title: "Checkout",
      ),
      actions: [
        SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                                hintText: "Enter Customer Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.primaryColor,
                                )),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            controller: number,
                            decoration: const InputDecoration(
                                hintText: "Enter Customer Mobile umber",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.primaryColor,
                                )),
                            validator: (val) {
                              if (val!.isEmpty || val.length<10) {
                                return 'Please enter valid contact number';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Payment Mode"),
                      const SizedBox(
                        width: 30,
                      ),
                      Radio<SingingCharacter>(
                        value: SingingCharacter.cash,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text("Cash"),
                      Radio<SingingCharacter>(
                        value: SingingCharacter.card,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text("Card"),
                      Radio<SingingCharacter>(
                        value: SingingCharacter.upi,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text("UPI"),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<OrderContentBloc>(context).add(
                        CheckoutOrderFBEvent(
                            name.text,
                            number.text,
                            isPaymentType(_character),
                            widget.totalPrice,
                            widget.id));
                    Navigator.pushReplacementNamed(context,RoutePaths.dashboard);
                  }
                },
                child: const Text("Checkout"),
              )
            ],
          ),
        )
      ],
    );
  }

  String isPaymentType(SingingCharacter? a) {
    switch (a) {
      case SingingCharacter.cash:
        return "cash";
      case SingingCharacter.card:
        return "card";
      case SingingCharacter.upi:
        return "UPI";
      default:
        return "cash";
    }
  }
}
