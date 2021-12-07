import 'package:phone_book_test/models/contat_model.dart';

abstract class HomeState{}

class HomeInitialState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeLoadedState extends HomeState{
  final List<ContactModel> contacts;

  HomeLoadedState({required this.contacts});
}

class HomeErrorState extends HomeState{}
