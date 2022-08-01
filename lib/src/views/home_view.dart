import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mia/src/views/architects_list_view.dart';
import 'package:mia/src/views/map_view.dart';

import 'buildings_list_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _selectedIndex = 0;

  static const List<Widget> _views = <Widget>[
    BuildingsListView(title: "Buildings"),
    MapView(title: "Places"),
    ArchitectsListView(title: "Architects")
  ];

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: 40,
            child: Image.asset("lib/assets/images/mia-logo.png")
        ),
        Container(
            padding: const EdgeInsets.all(6.0),
            child: const Text("MIA")
        )
      ]
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 40,
                              child: Image.asset("lib/assets/images/mia-logo.png")
                          ),
                          Container(
                              padding: const EdgeInsets.all(6.0),
                              child: const Text("MIA")
                          )
                        ]
                    );
                  }
                });
              },
              icon: customIcon,
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
        body: _views[_selectedIndex]
    );
  }
}