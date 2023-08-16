import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';

import '../../utils/common_card.dart';

class SalesDashboardPage extends StatefulWidget {
  const SalesDashboardPage({super.key});

  @override
  State<SalesDashboardPage> createState() => _SalesDashboardPageState();
}

class _SalesDashboardPageState extends State<SalesDashboardPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SalesDashboardBloc>(
      context,
    ).add(const DashboardPageinitevent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesDashboardBloc, SalesDashboardState>(
        builder: ((context, state) {
      if (state is SalesDashBoardLoadedState) {
        return Container(
          color: Colors.grey.shade100,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 200,
                  child: Row(
                    children: [
                      Expanded(
                          child: CommonCard(
                        title: "Today's Revenue",
                        amount: state.dailyValue.toString(),
                      )),
                      Expanded(
                          child: CommonCard(
                        title: "Weekly Revenue",
                        amount: state.weeklyValue.toString(),
                      )),
                      Expanded(
                          child: CommonCard(
                        title: "Monthly Revenue",
                        amount: state.monthlyValue.toString(),
                      )),
                    ],
                  ),
                ),
              ),

              ///TODO: Add specific Widgets
              Container(),

              ///TODO: Add specific Widgets
              Container(),
            ],
          ),
        );
      }
      return const SizedBox(
          height: 200,
          width: 200,
          child: Center(child: CircularProgressIndicator()));
    }));
  }
}
