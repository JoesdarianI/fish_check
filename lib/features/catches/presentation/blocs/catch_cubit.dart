import 'package:bloc/bloc.dart';
import 'package:fish_check/features/catches/domain/entities/catch.dart';
import 'package:fish_check/features/catches/domain/repositories/catch_repository.dart';

sealed class CatchState {
  const CatchState();
}

class CatchLoading extends CatchState {
  const CatchLoading();
}

class CatchLoaded extends CatchState {
  const CatchLoaded(this.catches);
  final List<FishCatch> catches;
}

class CatchFailure extends CatchState {
  const CatchFailure(this.message);
  final String message;
}

class CatchCubit extends Cubit<CatchState> {
  CatchCubit(this._repository) : super(const CatchLoading()) {
    load();
  }

  final CatchRepository _repository;

  Future<void> load() async {
    try {
      emit(CatchLoaded(await _repository.getCatches()));
    } catch (_) {
      emit(const CatchFailure('Could not load your catches.'));
    }
  }

  Future<void> addCatch({
    required String species,
    required String locationName,
    required double latitude,
    required double longitude,
    String note = '',
  }) async {
    final current = state;
    final fishCatch = FishCatch(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      species: species,
      locationName: locationName,
      latitude: latitude,
      longitude: longitude,
      caughtAt: DateTime.now(),
      note: note,
    );
    await _repository.addCatch(fishCatch);
    emit(CatchLoaded([
      fishCatch,
      if (current is CatchLoaded) ...current.catches,
    ]));
  }
}
