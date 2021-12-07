import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/models/contat_model.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  final ContactsRepo contactsRepo;
  List<ContactModel> contacts = [];
  HomeCubit({required this.contactsRepo}) : super(HomeInitialState());

  void loadContacts() async{
    emit(HomeLoadingState());
    try{
      await contactsRepo.loadContactsFromEthernet();
      contacts = contactsRepo.getContacts();
      emit(HomeLoadedState(contacts: contacts));
    }catch(e){
      /*if(e is NoInternetException){
        emit(HomeErrorState());
      }*/
      emit(HomeErrorState());
    }

  }

  void deleteContacts(int id) async{
    await contactsRepo.deleteContact(id);
  }
}