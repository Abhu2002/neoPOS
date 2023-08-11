import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'order_read_bloc.dart';

class OrderPageRead extends StatefulWidget {
  const OrderPageRead({super.key});

  @override
  State<OrderPageRead> createState() => _OrderPageReadState();
}

class _OrderPageReadState extends State<OrderPageRead> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderReadBloc>(context).add(OrderReadInitialEvent(
        true)); //creates connection and fetch all the map from firebase and add in the list
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrderReadBloc>().showMessage = createSnackBar;
    return BlocBuilder<OrderReadBloc, OrderReadState>(
        builder: (context, state) {
      if (state is OrderReadLoadedState) {
        List data = state.all;
        // var pressAttention = true;

        return LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(AppLocalizations.of(context)!.order_page,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ]),
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 210,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, i) => InkWell(
                            onTap: () {},
                            child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColors.tableAvailableColor,
                                    width: 10,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            (data[i]["tablename"]),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                            "${AppLocalizations.of(context)!.order_cap}: ${data[i]["tablecapacity"]}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                // Navigation to new Page
                                Navigator.pushNamed(context, "/menu",
                                    arguments: {"Id": data[i]["docID"]});
                              },
                            ),
                          )),
                ),
              )),
            ],
          );
        });
      } else {
        return const SizedBox(
            height: 200,
            width: 200,
            child: Center(child: CircularProgressIndicator()));
      }
    });
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
