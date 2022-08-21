// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'message_box_state.dart';

class MessageBoxCubit extends Cubit<MessageBoxState> {
  MessageBoxCubit() : super(const MessageBoxState.welcome());

  void show(
    String text,
    Duration duration,
  ) {
    emit(
      MessageBoxState(
        text: text,
        duration: duration,
      ),
    );
  }
}
