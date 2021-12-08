import 'package:flutter/material.dart';
import 'package:phone_book_test/utils/regex.dart';

class SurnameTextField extends StatelessWidget {
  final TextEditingController controller;

  const SurnameTextField({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        label: const Text(
          'surname',
          style: TextStyle(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter surname!';
        }
        if (!RegexExpressions.nameRegExp.hasMatch(value)) {
          return 'Invalid format!';
        }
      },
    );
  }
}
