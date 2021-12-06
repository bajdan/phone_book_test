import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/managers/data_manager.dart';

class DI extends StatelessWidget {
  const DI({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DataManager>(create: (context) => DataManager())
      ],
      child: child,
    );
  }
}