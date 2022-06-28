import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyPassScreen extends StatelessWidget {

  const EmptyPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Lottie.asset('assets/qrlottie.json'),
              ),
            ),
            Text(
              'There is nothing here.',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Not yet sold a pass ?\n'
              'Tap the + button to sell!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    
  }
}