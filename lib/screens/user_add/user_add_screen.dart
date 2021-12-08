import 'package:flutter/material.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/user_add/cubit/user_add_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/screens/user_add/widgets/name_text_field.dart';
import 'package:phone_book_test/screens/user_add/widgets/surname_text_field.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({Key? key}) : super(key: key);

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  late UserAddCubit _cubit;

  @override
  void initState() {
    _cubit = UserAddCubit(contactsRepo: context.read<ContactsRepo>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFdf6977),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                NameTextField(
                  controller: nameController,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SurnameTextField(
                  controller: surnameController,
                ),
                Expanded(
                  child: Container(),
                ),
                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'ADD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _cubit.createContact(
                          '${nameController.text} ${surnameController.text}');
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: const Color(0xFFdf6977),
                      onSurface: Colors.white),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
