import 'package:flutter/material.dart';
import 'package:mia/src/views/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/widgets/custom_title_bar.dart';


List titles = ["Buildings", "Places", "Architects"];

final appBarTitleProvider = StateProvider<String>((ref) {
  return titles[0];
});

final selectedViewIndex = StateProvider<int>((ref) {
  return 0;
});

final appBarIcon = StateProvider<Icon>((ref) {
  return const Icon(Icons.search);
});

final appBarType = StateProvider<Widget>((ref) {
  return const CustomTitleBar();
});

Future<void> main() async {
  await dotenv.load();
  runApp(
      const ProviderScope(
        child: Mia()
      ),
  );
}

class Mia extends HookConsumerWidget {
  const Mia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      title: 'Modernism in Architecture',
      home: HomeView(),
    );
  }
}
