part of 'playert_cubit.dart';

@immutable
class PlayertState {
  const PlayertState({
    this.oxygen = 100,
  });

  final int oxygen;

  PlayertState copyWith({
    int? oxygen,
  }) {
    return PlayertState(
      oxygen: oxygen ?? this.oxygen,
    );
  }
}
