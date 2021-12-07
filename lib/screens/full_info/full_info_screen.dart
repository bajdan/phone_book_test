import 'package:flutter/material.dart';
import 'package:phone_book_test/models/contat_model.dart';

class FullInfoScreen extends StatelessWidget {

  const FullInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final ContactModel contact = arguments['contact'];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(contact.createdTime.toString()),
              Text(contact.name),
              Text(contact.id.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
