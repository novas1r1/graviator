// ignore_for_file: public_member_api_docs

part of 'message_box_cubit.dart';

@immutable
class MessageBoxState extends Equatable {
  const MessageBoxState({
    required this.text,
    required this.duration,
  });

  const MessageBoxState.welcome()
      : this(
          duration: const Duration(seconds: 5),
          text: 'Hello world',
        );

  final String text;
  final Duration duration;

  @override
  List<Object?> get props => [text, duration];
}
