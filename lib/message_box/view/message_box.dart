// ignore_for_file: public_member_api_docs
import 'dart:math' as math;

import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
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
              padding: const EdgeInsets.all(10),
              child: ColoredBox(
                color: Colors.black.withOpacity(0.5),
                child: _TypewriterText(
                  text: text,
                  duration: duration,
                  onComplete: onComplete,
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
  });

  final String text;
  final Duration duration;
  final VoidCallback? onComplete;

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    upperBound: widget.text.length.toDouble() + 20,
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isCompleted = _controller.value.ceil() == _controller.upperBound;
      if (isCompleted) {
        widget.onComplete?.call();
        _controller.stop();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              style: const TextStyle(fontSize: 32),
              widget.text.substring(
                0,
                math.min(_controller.value.ceil(), widget.text.length),
              ),
            ),
          ),
        );
      },
    );
  }
}
