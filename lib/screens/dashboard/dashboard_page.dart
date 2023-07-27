import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/animated_button_widget.dart';
import '../login/login_page.dart';
import 'product_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(OnStarted());
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) { });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginPage()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
                key: Key("CircularProgressIndicator"),
              );
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.list[index].title),
                      leading: state.list[index].urlImage.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state.list[index].urlImage))
                          : const SizedBox(),
                      trailing:  SizedBox(
                        child: AnimatedButton(key: Key(index.toString()),),
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                },
                itemCount: state.list.isNotEmpty?10:0,
                key: const Key('ListView'),
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ));
  }
}
