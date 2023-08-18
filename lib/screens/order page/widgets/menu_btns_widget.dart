import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../order_menu_page/order_menu_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuBtnsWidget extends StatefulWidget {
  // immutable class but given data can vary
  final dynamic data;
  const MenuBtnsWidget({Key? key, this.data}) : super(key: key);

  @override
  State<MenuBtnsWidget> createState() => _MenuBtnsWidgetState();
}

class _MenuBtnsWidgetState extends State<MenuBtnsWidget> {
  num count = 0;
  late final List<Map<String,dynamic>> allInitialProds;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 1;
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(AppLocalizations.of(context)!.menu,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          BlocBuilder<OrderContentBloc, OrderContentState>(
            builder: (context, state) {
              if (state is ProductLoadingState ||
                  state is FilterProductsState) {
                List<String> allCats = state.allCats;
                List<Widget> catBtns = [];
                if(count == 1) {
                  allInitialProds = context.read<OrderContentBloc>().state.allProds;
                  count = 2;
                }
                catBtns.add(
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ActionChip(
                      elevation: 8.0,
                      avatar: const CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
                        child: Icon(
                          Icons.food_bank_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: const Text("All"),
                      onPressed: () {
                        BlocProvider.of<OrderContentBloc>(context)
                            .add(FilterProductsEvent("All",
                            allInitialProds, state.allCats,widget.data['Id'].toString()));
                      },
                      backgroundColor: (state.category == "All" ||
                          state.category == null)
                          ? Colors.orangeAccent
                          : Colors.white,
                      shape: const StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.orange,
                      )),
                    ),
                  ),
                );
                for (var element in allCats) {
                  catBtns.add(
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ActionChip(
                        elevation: 8.0,
                        avatar: const CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          child: Icon(
                            Icons.rice_bowl,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        label: Text(element),
                        onPressed: () {
                          BlocProvider.of<OrderContentBloc>(
                              context)
                              .add(FilterProductsEvent(element,
                              allInitialProds, state.allCats, widget.data['Id'].toString()));
                        },
                        backgroundColor: (state.category == element)
                            ? Colors.orangeAccent
                            : Colors.white,
                        shape: const StadiumBorder(
                            side: BorderSide(
                          width: 1,
                          color: Colors.orange,
                        )),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 95,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: catBtns,
                    ),
                  ),
                );
              }
              return const Spacer();
            },
          ),
        ],
      ),
    );
  }
}
