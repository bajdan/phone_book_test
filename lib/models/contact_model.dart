import 'dart:convert';

import 'package:phone_book_test/utils/json_reader.dart';

class ContactModel {
  final DateTime createdTime;
  final String name;
  final String avatar;
  final int id;

  ContactModel(
      {required this.createdTime,
      required this.name,
      required this.avatar,
      required this.id});

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    JsonReader reader = JsonReader(map);
    return ContactModel(
        createdTime: reader['createdAt'].asDateTime(),
        name: reader['name'].asString(),
        avatar: reader['avatar'].asString(),
        id: reader['id'].asInt());
  }

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  ContactModel copyWith(
      {DateTime? createdTime, String? name, String? avatar, int? id}) {
    return ContactModel(
        createdTime: createdTime ?? this.createdTime,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        id: id ?? this.id);
  }
}
