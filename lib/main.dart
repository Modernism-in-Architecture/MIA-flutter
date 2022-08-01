import 'package:flutter/material.dart';
import 'package:mia/src/views/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const Mia());
}

class Mia extends StatelessWidget {
  const Mia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Modernism in Architecture',
      home: HomeView(),
    );
  }
}
