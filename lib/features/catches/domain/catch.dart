import 'package:flutter/foundation.dart';

@immutable
class FishCatch {
  const FishCatch({
    required this.id,
    required this.species,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.caughtAt,
    this.note = '',
  });

  final String id;
  final String species;
  final String locationName;
  final double latitude;
  final double longitude;
  final DateTime caughtAt;
  final String note;
}
