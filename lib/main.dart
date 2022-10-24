import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';
import 'package:mia/src/models/list_building_model.dart';
import 'package:mia/src/network/mia_api_client.dart';
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

final searchQueryProvider = StateProvider<String>((ref) {
  return "";
});

final appBarIcon = StateProvider<Icon>((ref) {
  return const Icon(Icons.search);
});

final appBarType = StateProvider<Widget>((ref) {
  return const CustomTitleBar();
});

final buildingsListDataProvider = FutureProvider<List<ListBuildingModel>>((ref) async {
  return ref.read(miaApiProvider).getBuildings();
});

final architectsListDataProvider = FutureProvider<List<ListArchitectModel>>((ref) async {
  return ref.read(miaApiProvider).getArchitects();
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
