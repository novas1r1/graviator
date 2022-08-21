// ignore_for_file: public_member_api_docs
import 'dart:math' as math;

import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    super.key,
    required this.text,
    required this.duration,
    this.onComplete,
  });

  static const flameOverlayId = 'flame-overlay__message_box';

  final String text;
  final Duration duration;
  final VoidCallback? onComplete;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 128,
          vertical: 32,
        ),
        child: SizedBox(
          width: double.infinity,
          height: mediaQueryData.size.height * 0.15,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                child: _TypewriterText(
                  text: widget.text,
                  duration: widget.duration,
                  onComplete: widget.onComplete,
                  onNewCharacter: () => _scrollController.jumpTo(
                    _scrollController.position.maxScrollExtent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypewriterText extends StatefulWidget {
  const _TypewriterText({
    required this.text,
    required this.duration,
    this.onComplete,
    this.onNewCharacter,
  });

  final String text;
  final Duration duration;
  final VoidCallback? onComplete;
  final VoidCallback? onNewCharacter;

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      upperBound: widget.text.length.toDouble() + 20,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        widget.onNewCharacter?.call();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Material(
          color: Colors.black,
          child: Text(
            style: const TextStyle(fontSize: 32),
            widget.text.substring(
              0,
              math.min(_controller.value.ceil(), widget.text.length),
            ),
          ),
        );
      },
    );
  }
}
