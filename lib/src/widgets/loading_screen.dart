import 'package:flutter/material.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
            color: Colors.blue[900]
        ),
      ),
    );
  }
}