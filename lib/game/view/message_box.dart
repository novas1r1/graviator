// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  static const flameOverlayId = 'flame-overlay__message_box';

  final String text;

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
              color: const Color(0xff000000).withOpacity(0.8),
              border: Border.all(
                color: const Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
