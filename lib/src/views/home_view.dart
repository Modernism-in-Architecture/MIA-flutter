import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/views/architects_list_view.dart';
import 'package:mia/src/views/map_view.dart';
import '../helpers.dart';
import '../providers.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/custom_title_bar.dart';
import 'bookmark_view.dart';
import 'buildings_list_view.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  final List<Widget> _views = <Widget>[
    const BuildingsListView(),
    const MapView(),
    const ArchitectsListView(),
    const BookmarkView()
  ];

  @override
  void initState() {
    super.initState();
    dev.log('HomeView.initState()', name: 'MIA.UI');
    dev.log('Prefetch bookmarksProvider.future', name: 'MIA.UI');
    ref.read(bookmarksProvider.future);
    // ref.read(buildingsListDataProvider);
    // ref.read(architectsListDataProvider);

    getCurrentUserLocation().then((userLocation) {
      dev.log('getCurrentUserLocation() -> ${userLocation != null}', name: 'MIA.UI');
      if (userLocation != null) {
        ref.read(locationPermissionGrantedByUser.notifier).state = true;
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
    // final titleBarIcon = ref.watch(appBarIcon);
    final mode = ref.watch(appBarMode);
    final titleBarIconData = ref.watch(appBarIcon);
    final globalScaffold = ref.watch(scaffoldHomeViewKey);

    return PopScope(
        canPop: false,
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.building_2_fill),
                        label: 'Buildings',
                    ),
                    BottomNavigationBarItem(
                         icon: Icon(CupertinoIcons.map_fill),
                         label: 'Places',
                    ),
                    BottomNavigationBarItem(
                         icon: Icon(CupertinoIcons.person_2_fill),
                         label: 'Architects',
                       ),
                       BottomNavigationBarItem(
                         icon: Icon(CupertinoIcons.bookmark_fill),
                         label: 'Bookmarks',
                       ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: viewIndex,
                selectedItemColor: Colors.blue[900],
                onTap: _onBottomNavbarItemTapped,
          ),
          appBar: AppBar(
            title: mode == AppBarMode.title
                ? const CustomTitleBar()
                : const CustomSearchBar(),
              actions: [
                (viewIndex == 0 || viewIndex == 2) ? IconButton(
                  onPressed: () {
                    if (mode == AppBarMode.title) {
                      ref.read(appBarMode.notifier).state = AppBarMode.search;
                    } else {
                      ref.read(appBarMode.notifier).state = AppBarMode.title;
                      ref.read(searchQueryProvider.notifier).state = "";
                    }
                  },
                  icon: Icon(titleBarIconData, color: Colors.white),
                ) : const SizedBox.shrink(),
              ],
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            body: _views[viewIndex],
            key: globalScaffold,
            resizeToAvoidBottomInset: false,
          ),
    );
  }

  void _onBottomNavbarItemTapped(int index) {
    ref.read(selectedViewIndex.notifier).state = index;
    ref.read(selectedViewIndex.notifier).state = index;
    ref.read(appBarMode.notifier).state = AppBarMode.title; // new
    ref.read(appBarTitleProvider.notifier).state = titles[index];
    //final viewIndex = ref.watch(selectedViewIndex);
    //ref.read(appBarTitleProvider.notifier).state = titles[viewIndex];
    // ref.read(appBarTitleProvider.notifier).state = titles[index];
  }

}