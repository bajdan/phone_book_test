import 'package:flutter/material.dart';
import 'package:phone_book_test/models/contact_model.dart';
import 'package:phone_book_test/widgets/custom_image/custom_image.dart';

class CustomDBCard extends StatelessWidget {
  final ContactModel contact;

  const CustomDBCard({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: GestureDetector(
        child: Container(
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFF211f20),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20.0,
              ),
              CustomImage(
                size: 50.0,
                url: contact.avatar,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                contact.name,
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/full_info',
              arguments: {'contact': contact});
        },
      ),
    );
  }
}
