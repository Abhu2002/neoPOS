import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';
import 'package:neopos/utils/app_colors.dart';

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
    return BlocBuilder<OrderReadBloc, OrderReadState>(
        builder: (context, state) {
      if (state is OrderReadLoadedState) {
        List data = state.all;
        var pressAttention = true;

        return LayoutBuilder(builder: (ctx, constraints) {
          final width = constraints.maxWidth;
          return Column(children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Order Page",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ]),
            if (width > 500)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 320,
                    width: MediaQuery.sizeOf(context).width,
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
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    /// Todo set the press attention value once's live table check-in starts
                                    color: pressAttention
                                        ? AppColors.tableAvailableColor
                                        : AppColors
                                            .tableNotAvailableColor /* AppColors.mainTextColor*/,
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
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            (data[i]["tablename"]),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                            "Capacity: ${data[i]['tablecapacity']}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              )
            else if ((width > 350) && (width < 500))
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 520,
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
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  /// Todo set the press attention value once's live table check-in starts
                                  color: pressAttention
                                      ? AppColors.tableAvailableColor
                                      : AppColors
                                          .tableNotAvailableColor /* AppColors.mainTextColor*/,
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          (data[i]["tablename"]),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                          "Capacity: ${data[i]['tablecapacity']}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ))
            else
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 450,
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
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  /// Todo set the press attention value once's live table check-in starts
                                  color: pressAttention
                                      ? AppColors.tableAvailableColor
                                      : AppColors
                                          .tableNotAvailableColor /* AppColors.mainTextColor*/,
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          "Capacity: ${(data[i]["tablecapacity"]).toString()}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              )),
            if (width > 500)
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 420,
                      height: 80,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color.fromARGB(255, 248, 248, 248)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              "Table",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.tableAvailableColor,
                              minRadius: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              "Free : 3",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: CircleAvatar(
                              backgroundColor: AppColors.tableNotAvailableColor,
                              minRadius: 10,
                            ),
                          ),
                          Text(
                            "Checked-In : 5",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else if ((340 < width) && (width < 500))
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: MediaQuery.of(context).size.width - 420,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color.fromARGB(255, 248, 248, 248)),
                      child: const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Table",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.tableAvailableColor,
                              minRadius: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              "Free : 3",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundColor: AppColors.tableNotAvailableColor,
                              minRadius: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text("Checked-In: 5",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: MediaQuery.of(context).size.width - 380,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color.fromARGB(255, 248, 248, 248)),
                      child: const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Table",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.tableAvailableColor,
                              minRadius: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              "Free : 3",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundColor: AppColors.tableNotAvailableColor,
                              minRadius: 10,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text("Checked-In: 5",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ]);
        });
      } else {
        return const SizedBox(
            height: 200,
            width: 200,
            child: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
