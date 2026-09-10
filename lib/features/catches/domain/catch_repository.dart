import 'package:fish_check/features/catches/domain/catch.dart';

abstract interface class CatchRepository {
  Future<List<FishCatch>> getCatches();
  Future<void> addCatch(FishCatch fishCatch);
}
