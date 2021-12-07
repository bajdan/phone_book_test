import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  final ContactsRepo contactsRepo;
  HomeCubit({required this.contactsRepo}) : super(HomeInitialState());

  void loadContacts() async{
    emit(HomeLoadingState());
    final contacts = await contactsRepo.getContacts();
    emit(HomeLoadedState(contacts: contacts));
  }

  void deleteContacts(int id) async{
    await contactsRepo.deleteContact(id);
  }
}