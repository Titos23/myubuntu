import 'package:flutter/material.dart';

import '../components/pass_tile.dart';
import '../models/models.dart';

class PassListScreen extends StatelessWidget {
  final PassManager manager;

  const PassListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passItems = manager.passItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: passItems.length,
        itemBuilder: (context, index) {
          final item = passItems[index];
          return PassTile(
            key: Key(item.id),
            item: item);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
