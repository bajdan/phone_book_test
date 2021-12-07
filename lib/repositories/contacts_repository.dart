import 'package:phone_book_test/managers/api_manager.dart';
import 'package:phone_book_test/managers/model/delete_request.dart';
import 'package:phone_book_test/managers/model/get_request.dart';
import 'package:phone_book_test/managers/model/post_request.dart';
import 'package:phone_book_test/models/contat_model.dart';
import 'package:phone_book_test/utils/json_reader.dart';

abstract class IContactsRepo{
  List<ContactModel> getContacts();
  Future<void> loadContactsFromEthernet();
  Future<void> loadContactsFromDatabase();
  Future<void> deleteContact(int id);
  Future<void> createContact(String name);
}

class ContactsRepo extends IContactsRepo{
  final ApiManager apiManager;
  List<ContactModel> _contacts =[];

  ContactsRepo({required this.apiManager});

  @override
  Future<void> deleteContact(int id) async {
    final result = await apiManager.callApiRequest(DeleteRequest('users/$id'));
  }

  @override
  Future<void> loadContactsFromEthernet() async{
    final result = await apiManager.callApiRequest(GetRequest('users'));
    JsonReader reader = JsonReader(result);

    final contactsList = reader.asListOfObjects().map((e) => ContactModel.fromMap(e)).toList();
    _contacts = contactsList;
  }

  @override
  Future<void> createContact(String name) async{
    final result = await apiManager.callApiRequest(PostRequest('users',payload: {
      'name' : name
    }));
  }

  @override
  Future<void> loadContactsFromDatabase() async {
    // TODO: implement loadContactsFromDatabase
  }

  @override
  List<ContactModel> getContacts() {
    return _contacts;
  }



}