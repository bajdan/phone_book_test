import 'package:flutter/material.dart';

class FormattedText extends StatelessWidget {
  final String label;
  final String data;

  const FormattedText({required this.label, required this.data, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: label,
              style: const TextStyle(
                color: Color(0xFFdf6977),
              ),
            ),
            TextSpan(
              text: data,
              style: const TextStyle(color: Colors.white),
            ),
          ]),
        ),
      ],
    );
  }
}
