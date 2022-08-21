// ignore_for_file: public_member_api_docs

part of 'astronaut_cubit.dart';

enum AstronautStatus {
  alive,
  dead,
}

@immutable
class AstronautState {
  const AstronautState({
    this.oxygen = 100,
    this.health = 100,
    this.astronautStatus = AstronautStatus.alive,
  });

  final int oxygen;
  final int health;
  final AstronautStatus astronautStatus;

  AstronautState copyWith({
    int? oxygen,
    int? health,
    AstronautStatus? astronautStatus,
  }) {
    return AstronautState(
      oxygen: oxygen ?? this.oxygen,
      health: health ?? this.health,
      astronautStatus: astronautStatus ?? this.astronautStatus,
    );
  }
}
