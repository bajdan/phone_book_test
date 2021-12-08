import 'package:phone_book_test/managers/api_manager.dart';
import 'package:phone_book_test/managers/db_manager.dart';
import 'package:phone_book_test/managers/model/delete_request.dart';
import 'package:phone_book_test/managers/model/get_request.dart';
import 'package:phone_book_test/managers/model/post_request.dart';
import 'package:phone_book_test/models/contact_model.dart';
import 'package:phone_book_test/utils/json_reader.dart';

abstract class IContactsRepo {
  List<ContactModel> getContacts();

  Future<void> loadContactsFromEthernet();

  Stream<List<ContactModel>> loadContactsFromDatabase();

  Future<void> deleteContact(int id);

  Future<void> createContact(String name);

  Future<void> saveUserList(List<ContactModel> contacts);
}

class ContactsRepo extends IContactsRepo {
  final ApiManager apiManager;
  final DataBaseManager dbManager;
  List<ContactModel> _contacts = [];

  ContactsRepo({required this.apiManager, required this.dbManager});

  @override
  List<ContactModel> getContacts() {
    return _contacts;
  }

  @override
  Future<void> loadContactsFromEthernet() async {
    final result = await apiManager.callApiRequest(GetRequest('users'));
    JsonReader reader = JsonReader(result);

    final contactsList =
        reader.asListOfObjects().map((e) => ContactModel.fromMap(e)).toList();
    _contacts = contactsList;
  }

  @override
  Stream<List<ContactModel>> loadContactsFromDatabase() {
    return dbManager.watchContacts();
  }

  @override
  Future<void> createContact(String name) async {
    await apiManager
        .callApiRequest(PostRequest('users', payload: {'name': name}));
  }

  @override
  Future<void> deleteContact(int id) async {
    await dbManager.deleteContactFromDB(id);
    await apiManager.callApiRequest(DeleteRequest('users/$id'));
    _contacts.removeWhere((contact) => contact.id == id);

  }

  @override
  Future<void> saveUserList(List<ContactModel> contacts) async {
    await dbManager.saveUserList(contacts);
  }
}
