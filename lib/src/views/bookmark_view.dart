import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/models/list_building_model.dart';
import '../providers.dart';
import 'building_detail_view.dart';


class BookmarkView extends ConsumerStatefulWidget {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  BookmarkViewState createState() => BookmarkViewState();
}


class BookmarkViewState extends ConsumerState<BookmarkView> {

  @override
  Widget build(BuildContext context) {
    final listBuildings = ref.watch(buildingsListDataProvider);
    final bookmarks = ref.watch(bookmarksProvider);

    List<ListBuildingModel> resultBuildings = [];

    listBuildings.whenData( (buildings) {
        for (var building in buildings) {
            if (bookmarks.bookmarks.contains(building.id)) {
                resultBuildings.add(building);
            }
        }
    });

    if (resultBuildings.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
          itemCount: resultBuildings.length,
          itemBuilder: (context, index) {
              return Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                      bookmarks.removeBookmark(resultBuildings[index].id);
                      resultBuildings.remove(resultBuildings[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bookmark deleted')));
                  },
                  background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                              CupertinoIcons.delete_simple,
                              color: Colors.white
                          )
                      )
                  ),
                  child: GestureDetector(
                      onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuildingDetailView(
                                      buildingId: resultBuildings[index].id,
                                  ),
                              ),
                          );
                      },
                      child: SizedBox(
                          height: 70,
                          child: Card(
                              elevation: 1,
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                          Text(
                                              resultBuildings[index].name,
                                              style: const TextStyle(
                                                  fontSize: 16
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1
                                          ),
                                          Text(
                                              "${resultBuildings[index].city}, ${resultBuildings[index].country}",
                                              style: const TextStyle(
                                                  fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1
                                          ),
                                      ]
                                  )
                              )
                          )
                      )
                  )
              );
          }
      );
    } else {
        return const Center(child: Text("No bookmarks yet."));
    }
  }
}

