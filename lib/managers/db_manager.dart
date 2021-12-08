import 'package:phone_book_test/core/database/app_database.dart';
import 'package:phone_book_test/models/contact_model.dart';

abstract class IDataBaseManager {
  Stream<List<ContactModel>> watchContacts();

  Future<void> saveUserList(List<ContactModel> contacts);

  Future<void> updateUserDb(List<ContactModel> contacts);

  void deleteContactFromDB(int id);
}

class DataBaseManager extends IDataBaseManager {
  final MyDatabase dataBase;

  DataBaseManager({required this.dataBase});

  @override
  Future<void> saveUserList(List<ContactModel> contacts) async {
    await dataBase.contactDao.saveUserList(contacts);
  }

  @override
  Future<void> updateUserDb(List<ContactModel> contacts) async {
    await dataBase.contactDao.updateUserDb(contacts);
  }

  @override
  Stream<List<ContactModel>> watchContacts() {
    return dataBase.contactDao.watchContacts();
  }

  @override
  Future deleteContactFromDB(int id) {
    return dataBase.contactDao.deleteContactFromDB(id);
  }
}
