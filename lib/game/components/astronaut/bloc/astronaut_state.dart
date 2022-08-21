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
    this.playerStatus = AstronautStatus.alive,
  });

  final int oxygen;
  final int health;
  final AstronautStatus playerStatus;

  AstronautState copyWith({
    int? oxygen,
    int? health,
    AstronautStatus? playerStatus,
  }) {
    return AstronautState(
      oxygen: oxygen ?? this.oxygen,
      health: health ?? this.health,
      playerStatus: playerStatus ?? this.playerStatus,
    );
  }
}
