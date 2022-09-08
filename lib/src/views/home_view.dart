import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/views/architects_list_view.dart';
import 'package:mia/src/views/map_view.dart';
import '../../main.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/custom_title_bar.dart';
import 'buildings_list_view.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}


class HomeViewState extends ConsumerState<HomeView> {

  final List<Widget> _views = <Widget>[
    const BuildingsListView(),
    const MapView(),
    const ArchitectsListView()
  ];

  void _onBottomNavbarItemTapped(int index) {
    ref.read(selectedViewIndex.notifier).state = index;
    final viewIndex = ref.watch(selectedViewIndex);
    ref.read(appBarTitleProvider.notifier).state = titles[viewIndex];
  }

  @override
  Widget build(BuildContext context) {
    final viewIndex = ref.watch(selectedViewIndex);
    final titleBarIcon = ref.watch(appBarIcon);

    return Scaffold(
        appBar: AppBar(
          title: ref.read(appBarType),
          actions: [
            IconButton(
              onPressed: () {
                  if (titleBarIcon.icon == Icons.search) {
                    ref.read(appBarIcon.notifier).state = const Icon(Icons.cancel);
                    ref.read(appBarType.notifier).state = const CustomSearchBar();
                  } else {
                    ref.read(appBarIcon.notifier).state = const Icon(Icons.search);
                    ref.read(appBarType.notifier).state = const CustomTitleBar();
                  }
              },
              icon: titleBarIcon,
            ),
          ],
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.building_2_fill),
              label: 'Buildings',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.map),
              label: 'Places',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2_fill),
              label: 'Architects',
            ),
          ],
          currentIndex: viewIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onBottomNavbarItemTapped,
        ),
        body: _views[viewIndex]
    );
  }
}