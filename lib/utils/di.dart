import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/managers/api_manager.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';

class DI extends StatelessWidget {
  const DI({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiManagerImpl>(create: (context) => ApiManagerImpl()),
        RepositoryProvider<ContactsRepo>(create: (context) => ContactsRepo(apiManager:
        context.read<ApiManagerImpl>()))
      ],
      child: child,
    );
  }
}