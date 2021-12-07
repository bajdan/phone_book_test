import 'package:phone_book_test/managers/api_manager.dart';
import 'package:phone_book_test/managers/model/delete_request.dart';
import 'package:phone_book_test/managers/model/get_request.dart';
import 'package:phone_book_test/models/contat_model.dart';
import 'package:phone_book_test/utils/json_reader.dart';

abstract class IContactsRepo{
  Future<List<ContactModel>> getContacts();
  Future<void> deleteContact(int id);
  Future<void> createContact(String name);
}

class ContactsRepo extends IContactsRepo{
  final ApiManager apiManager;

  ContactsRepo({required this.apiManager});

  @override
  Future<void> deleteContact(int id) async {
    final result = await apiManager.callApiRequest(DeleteRequest('users/$id'));
  }

  @override
  Future<List<ContactModel>> getContacts() async{
    final result = await apiManager.callApiRequest(GetRequest('users'));
    JsonReader reader = JsonReader(result);

    final contactsList = reader.asListOfObjects().map((e) => ContactModel.fromMap(e)).toList();
    return contactsList;
  }

  @override
  Future<void> createContact(String name) {
    // TODO: implement createContact
    throw UnimplementedError();
  }

}