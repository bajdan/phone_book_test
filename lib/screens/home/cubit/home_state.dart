import 'package:phone_book_test/models/contact_model.dart';

abstract class HomeState{}

class HomeInitialState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeLoadedState extends HomeState{
  final List<ContactModel> contacts;

  HomeLoadedState({required this.contacts});
}

class HomeLoadedFromDBState extends HomeState{
  final Stream<List<ContactModel>> contactStream;
  HomeLoadedFromDBState({required this.contactStream});
}

class HomeErrorState extends HomeState{}
