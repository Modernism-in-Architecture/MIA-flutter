import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers.dart';
import '../models/list_building_model.dart';
import '../providers.dart';
import '../widgets/building_list/list_buildings_view.dart';
import '../widgets/loading_screen.dart';


class BuildingsListView extends ConsumerStatefulWidget {
  const BuildingsListView({super.key});

  @override
  BuildingsListViewState createState() => BuildingsListViewState();
}

class BuildingsListViewState extends ConsumerState<BuildingsListView> {

  @override
  Widget build(BuildContext context) {
    final buildingsAsync = ref.watch(buildingsListDataProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return buildingsAsync.when(
      loading: () => const LoadingScreen(),

      error: (e, st) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Failed to load buildings'),
            const SizedBox(height: 8),
            Text(
              e.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => ref.invalidate(buildingsListDataProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),

      data: (buildings) {
        final q = removeDiacritics(searchQuery).toLowerCase().trim();
        final List<ListBuildingModel> filtered = q.isEmpty
            ? buildings
            : buildings.where((b) {
          final name = removeDiacritics(b.name).toLowerCase();
          final city = removeDiacritics(b.city).toLowerCase();
          final country = removeDiacritics(b.country).toLowerCase();
          return name.contains(q) || city.startsWith(q) || country.startsWith(q);
        }).toList();

        if (filtered.isEmpty) {
          return const Center(child: Text('Sorry, no results'));
        }
        return ListBuildingsView(listBuildings: filtered);
      },
    );
  }}