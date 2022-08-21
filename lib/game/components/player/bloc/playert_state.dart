// ignore_for_file: public_member_api_docs

part of 'playert_cubit.dart';

enum PlayerStatus {
  alive,
  dead,
}

@immutable
class PlayertState {
  const PlayertState({
    this.oxygen = 100,
    this.health = 100,
    this.playerStatus = PlayerStatus.alive,
  });

  final int oxygen;
  final int health;
  final PlayerStatus playerStatus;

  PlayertState copyWith({
    int? oxygen,
    int? health,
    PlayerStatus? playerStatus,
  }) {
    return PlayertState(
      oxygen: oxygen ?? this.oxygen,
      health: health ?? this.health,
      playerStatus: playerStatus ?? this.playerStatus,
    );
  }
}
