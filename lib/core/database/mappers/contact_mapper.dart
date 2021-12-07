part of '../dao/contact_dao.dart';

List<ContactModel> mapToContactList(List<ContactsTableData> dbContact) {
  return dbContact.map((e) => mapToContact(e)).toList();
}

List<ContactsTableData> mapToDbContactList(List<ContactModel> contacts) {
  return contacts.map((e) => mapToDbContact(e)).toList();
}

ContactsTableData mapToDbContact(ContactModel contact) {
  return ContactsTableData(
    createdAt: DateTime.now(),
    name: contact.name,
    avatar: contact.avatar,
    id: contact.id,
  );
}

ContactModel mapToContact(ContactsTableData dbContact) {
  return ContactModel(
    createdTime: dbContact.createdAt,
    name: dbContact.name,
    avatar: dbContact.avatar,
    id: dbContact.id,
  );
}