import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'empty_pass_screen.dart';
import 'pass_list_screen.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sold Pass')),
        actions: const[
          Padding (padding: EdgeInsets.only(right: 20),child: Icon(Icons.account_circle),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<PassManager>(context, listen: false);
          manager.createNewItem();
        },
      ),
      body: buildpassScreen(),
    );
  }

  Widget buildpassScreen() {
    return Consumer<PassManager>(
      builder: (context, manager, child) {
        if (manager.passItems.isNotEmpty) {
          return PassListScreen(manager: manager);
        } else {
          return const EmptyPassScreen();
        }
      },
    );
  }
}
