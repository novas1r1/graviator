// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template game.helpers.ReadBloc}
/// Convinient method to retrieve a [FlameBlocProvider].
/// {@endtemplate}
extension ReadBloc on Component {
  /// {@macro game.helpers.ReadBloc}
  B readBloc<B extends BlocBase<S>, S>() {
    final providers = ancestors().whereType<FlameBlocProvider<B, S>>();
    assert(
      providers.isNotEmpty,
      'No FlameBlocProvider<$B, $S> available on the component tree',
    );

    return providers.first.bloc;
  }
}
