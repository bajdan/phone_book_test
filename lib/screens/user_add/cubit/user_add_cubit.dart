import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book_test/repositories/contacts_repository.dart';
import 'package:phone_book_test/screens/user_add/cubit/user_add_state.dart';

class UserAddCubit extends Cubit<UserAddState>{
  final ContactsRepo contactsRepo;
  UserAddCubit({required this.contactsRepo}) : super(UserAddState());

  Future<void> createContact(String name) async{
    BotToast.showLoading();
    try{
      await contactsRepo.createContact(name);
    }catch(e){
      BotToast.showText(text: e.toString());
    }
    BotToast.cleanAll();
  }

}