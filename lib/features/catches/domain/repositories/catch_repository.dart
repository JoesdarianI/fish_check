import 'package:fish_check/features/catches/domain/entities/catch.dart';

abstract interface class CatchRepository {
  Future<List<FishCatch>> getCatches();
  Future<void> addCatch(FishCatch fishCatch);
}
