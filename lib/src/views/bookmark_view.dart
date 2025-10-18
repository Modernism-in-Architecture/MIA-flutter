import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers.dart';
import 'building_detail_view.dart';


class BookmarkView extends ConsumerStatefulWidget {
  const BookmarkView({super.key});

  @override
  BookmarkViewState createState() => BookmarkViewState();
}


class BookmarkViewState extends ConsumerState<BookmarkView> {

  @override
  Widget build(BuildContext context) {
    final buildingsAsync = ref.watch(buildingsListDataProvider);
    final bookmarksAsync = ref.watch(bookmarksProvider);

    return buildingsAsync.when(
      data: (buildings) {
        return bookmarksAsync.when(
          data: (ids) {
            final resultBuildings = buildings
                .where((b) => ids.contains(b.id))
                .toList(growable: true);

            if (resultBuildings.isEmpty) {
              return const Center(child: Text("No bookmarks yet."));
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
              itemCount: resultBuildings.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(resultBuildings[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await ref.read(bookmarksProvider.notifier).remove(resultBuildings[index].id);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bookmark deleted')),);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(CupertinoIcons.delete_simple, color: Colors.white),
                    ),
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
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                "${resultBuildings[index].city}, ${resultBuildings[index].country}",
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Error loading bookmarks')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const Center(child: Text('Error loading buildings')),
    );
  }
}

