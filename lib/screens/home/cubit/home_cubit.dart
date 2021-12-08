import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/models/contact_model.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ContactsRepo contactsRepo;
  List<ContactModel> contacts = [];

  HomeCubit({required this.contactsRepo}) : super(HomeInitialState()) {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        loadContactsFromNetwork();
      }
    });
  }

  void loadContactsFromNetwork() async {
    emit(HomeLoadingState());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      loadContactsFromDB();
    } else {
      try {
        await contactsRepo.loadContactsFromEthernet();
        contacts = contactsRepo.getContacts();
        emit(HomeLoadedState(contacts: contacts));
        saveContactsToBD();
      } catch (e) {
        emit(HomeErrorState());
      }
    }
  }

  void loadContactsFromDB() async {
    emit(HomeLoadingState());
    try {
      emit(HomeLoadedFromDBState(
          contactStream: contactsRepo.loadContactsFromDatabase()));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  Future<void> deleteContact(int id) async {
    await contactsRepo.deleteContact(id);
    contacts.removeWhere((contact) => contact.id == id);
    saveContactsToBD();
  }

  Future<void> saveContactsToBD() async {
    await contactsRepo.saveUserList(contacts);
  }
}
