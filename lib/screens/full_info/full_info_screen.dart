import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_book_test/models/contact_model.dart';
import 'package:phone_book_test/screens/full_info/widgets/formatted_text.dart';
import 'package:phone_book_test/widgets/custom_image/custom_image.dart';

class FullInfoScreen extends StatelessWidget {
  const FullInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final ContactModel contact = arguments['contact'];

    return Scaffold(
      backgroundColor: const Color(0xFF3f3f3f),
      appBar: AppBar(
        title: const Text('THE DETAILS'),
        centerTitle: true,
        backgroundColor: const Color(0xFF211f20),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(
                      size: MediaQuery.of(context).size.width * 0.5,
                      url: contact.avatar),
                  FormattedText(
                    label: 'Created at: ',
                    data: DateFormat('yyyy-MM-dd – kk:mm')
                        .format(contact.createdTime),
                  ),
                  FormattedText(
                    label: 'Name: ',
                    data: contact.name,
                  ),
                  FormattedText(
                    label: 'Id: ',
                    data: contact.id.toString(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
