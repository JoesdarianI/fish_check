import 'package:fish_check/features/catches/domain/entities/catch.dart';
import 'package:fish_check/features/catches/domain/repositories/catch_repository.dart';

class InMemoryCatchRepository implements CatchRepository {
  final List<FishCatch> _catches = [
    FishCatch(
      id: '1',
      species: 'Rainbow trout',
      locationName: 'Emerald Lake',
      latitude: 46.805,
      longitude: -121.726,
      caughtAt: DateTime(2026, 8, 28),
      note: 'Caught just before sunset.',
    ),
    FishCatch(
      id: '2',
      species: 'Smallmouth bass',
      locationName: 'Cedar Creek',
      latitude: 46.815,
      longitude: -121.70,
      caughtAt: DateTime(2026, 8, 14),
    ),
    FishCatch(
      id: '3',
      species: 'Chinook salmon',
      locationName: 'North Bay',
      latitude: 46.79,
      longitude: -121.75,
      caughtAt: DateTime(2026, 7, 30),
    ),
  ];

  @override
  Future<List<FishCatch>> getCatches() async => List.unmodifiable(_catches);

  @override
  Future<void> addCatch(FishCatch fishCatch) async => _catches.insert(0, fishCatch);
}
