import 'package:fish_check/core/theme/app_colors.dart';
import 'package:fish_check/features/auth/presentation/auth_cubit.dart';
import 'package:fish_check/features/catches/domain/entities/catch.dart';
import 'package:fish_check/features/catches/presentation/blocs/catch_cubit.dart';
import 'package:fish_check/features/catches/presentation/new_catch_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mapController = MapController();
  int _selectedTab = 0;

  Future<void> _addCatch() async {
    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const NewCatchSheet(),
    );
    if (added == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Catch added to your map.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FishCheck'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () => context.read<AuthCubit>().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _selectedTab == 0 ? _buildMap() : _buildCatchList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCatch,
        icon: const Icon(Icons.add_location_alt_outlined),
        label: const Text('Log catch'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'My catches',
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return BlocBuilder<CatchCubit, CatchState>(
      builder: (context, state) {
        final catches = state is CatchLoaded ? state.catches : <FishCatch>[];
        return Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(46.805, -121.726),
                initialZoom: 12.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.joes.fish_check',
                ),
                const RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      '© OpenStreetMap contributors',
                      // Optional: opens the license page when tapped
                      onTap: null,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: catches
                      .map(
                        (fishCatch) => Marker(
                          point: LatLng(
                            fishCatch.latitude,
                            fishCatch.longitude,
                          ),
                          width: 48,
                          height: 48,
                          child: Tooltip(
                            message:
                                '${fishCatch.species} · ${fishCatch.locationName}',
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryOcean,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.phishing,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution('OpenStreetMap contributors'),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Icon(Icons.explore, color: AppColors.secondaryTeal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${catches.length} catches mapped in your waters',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Reset map',
                        onPressed: () => _mapController.move(
                          const LatLng(46.805, -121.726),
                          12.5,
                        ),
                        icon: const Icon(Icons.my_location),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCatchList() {
    return BlocBuilder<CatchCubit, CatchState>(
      builder: (context, state) {
        if (state is CatchLoading)
          return const Center(child: CircularProgressIndicator());
        if (state is CatchFailure) return Center(child: Text(state.message));
        final catches = (state as CatchLoaded).catches;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            Text(
              'Your fishing journal',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text('Every catch has a story. Keep yours on the map.'),
            const SizedBox(height: 18),
            ...catches.map(_catchCard),
          ],
        );
      },
    );
  }

  Widget _catchCard(FishCatch fishCatch) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundColor: AppColors.secondaryTeal.withAlpha(30),
          child: const Icon(Icons.phishing, color: AppColors.secondaryTeal),
        ),
        title: Text(
          fishCatch.species,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${fishCatch.locationName}\n${_formatDate(fishCatch.caughtAt)}',
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
