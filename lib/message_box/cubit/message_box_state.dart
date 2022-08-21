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
          duration: const Duration(seconds: 20),
          text: 'Commander: Hello Pilot! Hello PILOT! Do you hear me?\n'
              "I'm glad you're still alive. Apparently, we've suffered an attack and our spaceship is seriously damaged.\n\n"
              'The oxygen pump system is malfunctioning. We need to repair it immediately!',
        );

  final String text;
  final Duration duration;

  @override
  List<Object?> get props => [text, duration];
}
