import 'package:drift/drift.dart';
import 'package:phone_book_test/core/database/app_database.dart';
import 'package:phone_book_test/core/database/tables/contacts_table.dart';
import 'package:phone_book_test/models/contat_model.dart';

part '../mappers/contact_mapper.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [ContactsTable])
class ContactDao extends DatabaseAccessor<MyDatabase> with _$ContactDaoMixin {
  ContactDao(MyDatabase db) : super(db);

  Stream<List<ContactModel>> watchContacts() {
    return select(contactsTable).watch().map((event) {
      return mapToContactList(event);
    });
  }

  Future<void> saveUserList(List<ContactModel> contacts) async {
    await batch((b) {
      b.insertAll(
        contactsTable,
        mapToDbContactList(contacts),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> updateUserDb(List<ContactModel> contacts) async {
    await batch((b) {
      b.replaceAll(
        contactsTable,
        mapToDbContactList(contacts),
      );
    });
  }
}