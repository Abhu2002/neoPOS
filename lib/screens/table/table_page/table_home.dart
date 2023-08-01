import 'package:flutter/material.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';
import 'package:neopos/screens/table/table_page/table_page.dart';
import 'package:provider/provider.dart';
import 'package:neopos/repository/tables_read.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRead extends StatelessWidget {
  const HomeRead({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      TablesRepository repo = Provider.of<TablesRepository>(context);
      return BlocProvider(
        create: (context) => TablesBloc(tablesRepository: repo),
        child: BlocBuilder<TablesBloc, TableState>(builder: (context, state) {
          if (state is TableAdding) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TableError) {
            return const Center(child: Text("Error"));
          }
          return const TableRead();
        }),
      );
    });
  }
}
