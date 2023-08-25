import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/sales_dashboard/widget/top5_product_page/top5_bloc.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopFiveProduct extends StatefulWidget {
  final data;

  const TopFiveProduct({super.key, this.data});

  @override
  State<TopFiveProduct> createState() => _TopFiveProductState();
}

class _TopFiveProductState extends State<TopFiveProduct> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<Top5Bloc>(context).add(LoadallData(widget.data));
    BlocProvider.of<Top5Bloc>(context).add(const SelectKeyEvent("Daily"));
  }

  // List of items in our dropdown menu
  var items = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Top5Bloc, Top5State>(
      builder: (context, state) {
        if (state is LoadedState) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 265,
              child: Column(children: [
                SizedBox(
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.top_5_products,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value: state.state,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (value) {
                            BlocProvider.of<Top5Bloc>(context)
                                .add(SelectKeyEvent(value!));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                      itemCount: state.all.length,
                      itemBuilder: (context, index) {
                        String key = state.all.keys.elementAt(index);
                        return SizedBox(
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${index + 1}.",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  )),
                              Expanded(flex: 4, child: Text(key))
                            ]),
                          ),
                        );
                      }),
                )
              ]),
            ),
          );
        } else {
          return const SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator());
        }
      },
    );
  }
}
