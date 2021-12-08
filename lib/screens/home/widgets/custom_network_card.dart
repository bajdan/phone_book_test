import 'package:flutter/material.dart';
import 'package:phone_book_test/models/contact_model.dart';
import 'package:phone_book_test/widgets/custom_image/custom_image.dart';

class CustomNetworkCad extends StatefulWidget {
  final ContactModel contact;

  const CustomNetworkCad({required this.contact, Key? key}) : super(key: key);

  @override
  State<CustomNetworkCad> createState() => _CustomNetworkCadState();
}

class _CustomNetworkCadState extends State<CustomNetworkCad> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              url: widget.contact.avatar,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              widget.contact.name,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/full_info',
            arguments: {'contact': widget.contact});
      },
    );
  }
}
