import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/views/architects_list_view.dart';
import 'package:mia/src/views/map_view.dart';
import '../helpers.dart';
import '../providers.dart';
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

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation().then((userLocation) {
      if (userLocation != null) {
        ref.read(mapLocation.notifier).state = MapLocation(
            latitude: userLocation.latitude, longitude: userLocation.longitude
        );
        ref.read(currentUserLocation.notifier).state = MapLocation(
            latitude: userLocation.latitude, longitude: userLocation.longitude
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewIndex = ref.watch(selectedViewIndex);
    final titleBarIcon = ref.watch(appBarIcon);
    final globalScaffold = ref.watch(scaffoldHomeViewKey);

    return  WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
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
           selectedItemColor: Colors.blue[900],
           onTap: _onBottomNavbarItemTapped,
        ),
        appBar: AppBar(
          title: ref.watch(appBarType),
          actions: [
            IconButton(
              onPressed: () {
                  if (titleBarIcon.icon == CupertinoIcons.search) {
                    ref.read(appBarIcon.notifier).state = const Icon(CupertinoIcons.xmark_circle);
                    ref.read(appBarType.notifier).state = const CustomSearchBar();
                  } else {
                    ref.read(appBarIcon.notifier).state = const Icon(CupertinoIcons.search);
                    ref.read(appBarType.notifier).state = const CustomTitleBar();
                    ref.read(searchQueryProvider.notifier).state = "";
                  }
              },
              icon: titleBarIcon,
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: _views[viewIndex],
        key: globalScaffold,

    )
    );
  }

  void _onBottomNavbarItemTapped(int index) {
    ref.read(selectedViewIndex.notifier).state = index;
    final viewIndex = ref.watch(selectedViewIndex);
    ref.read(appBarTitleProvider.notifier).state = titles[viewIndex];
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('EXIT YOUR FAVORITE APP'),
        content: const Text('Do you really want to exit MIA?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue[900]!),
            ),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
            ),
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ??false;
  }
}