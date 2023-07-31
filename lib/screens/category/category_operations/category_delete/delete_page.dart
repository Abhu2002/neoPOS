import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_bloc.dart';
import 'delete_event.dart';
import 'delete_state.dart';

class CategoryDeletionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Deletion'),
      ),
      body: CategoryList(),
    );
  }
}

class CategoryList extends StatelessWidget {

  var id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<CategoryDeletionBloc, CategoryDeletionState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showErrorDialog(context, state.error);
          } else if (state is ConfirmationState) {
            showConfirmationDialog(context);
          } else if (state is CategoryDeleteState) {
            showSnackBar(context, 'Category deleted successfully.');
          }
        },
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('category').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Widget> tableWidgets = [];
              snapshot.data?.docs.forEach((doc) {
                String categoryId = doc.id;
                String categoryName = doc['category_name'].toString();

                tableWidgets.add(
                  Card(
                    elevation: 3,
                    color: Colors.orange.shade50,
                    child: ListTile(
                      title: Text('Category Id: $categoryId'),
                      subtitle: Text('Category Name: $categoryName'),
                      onTap: () {
                        showCredentialsDialog(context, categoryId);
                      },
                    ),
                  ),
                );
              });

              return ListView(
                children: tableWidgets,
              );
            },
          );
        },
      ),
    );
  }

  void showCredentialsDialog(BuildContext context, String tableId) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    id = tableId;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Credentials'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'Username'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<CategoryDeletionBloc>(context).add(
                  CredentialsEnteredEvent(
                    _usernameController.text,
                    _passwordController.text,
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: Text('Are you sure you want to delete this table?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<CategoryDeletionBloc>(context).deleteTable(id);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }



  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}