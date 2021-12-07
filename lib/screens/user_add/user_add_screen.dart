import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/user_add/cubit/user_add_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: nameController
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: surnameController
              ),
              Expanded(
                child: Container(),
              ),
              ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'ДОБАВИТЬ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){

                   await  _cubit.createContact('${nameController.text} ${surnameController.text}');
                   Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
