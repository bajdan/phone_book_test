// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ContactsTableData extends DataClass
    implements Insertable<ContactsTableData> {
  final DateTime createdAt;
  final String name;
  final String avatar;
  final int id;
  ContactsTableData(
      {required this.createdAt,
      required this.name,
      required this.avatar,
      required this.id});
  factory ContactsTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ContactsTableData(
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      avatar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    map['avatar'] = Variable<String>(avatar);
    map['id'] = Variable<int>(id);
    return map;
  }

  ContactsTableCompanion toCompanion(bool nullToAbsent) {
    return ContactsTableCompanion(
      createdAt: Value(createdAt),
      name: Value(name),
      avatar: Value(avatar),
      id: Value(id),
    );
  }

  factory ContactsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactsTableData(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String>(json['avatar']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String>(avatar),
      'id': serializer.toJson<int>(id),
    };
  }

  ContactsTableData copyWith(
          {DateTime? createdAt, String? name, String? avatar, int? id}) =>
      ContactsTableData(
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('ContactsTableData(')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, name, avatar, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactsTableData &&
          other.createdAt == this.createdAt &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.id == this.id);
}

class ContactsTableCompanion extends UpdateCompanion<ContactsTableData> {
  final Value<DateTime> createdAt;
  final Value<String> name;
  final Value<String> avatar;
  final Value<int> id;
  const ContactsTableCompanion({
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.id = const Value.absent(),
  });
  ContactsTableCompanion.insert({
    required DateTime createdAt,
    required String name,
    required String avatar,
    this.id = const Value.absent(),
  })  : createdAt = Value(createdAt),
        name = Value(name),
        avatar = Value(avatar);
  static Insertable<ContactsTableData> custom({
    Expression<DateTime>? createdAt,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (id != null) 'id': id,
    });
  }

  ContactsTableCompanion copyWith(
      {Value<DateTime>? createdAt,
      Value<String>? name,
      Value<String>? avatar,
      Value<int>? id}) {
    return ContactsTableCompanion(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsTableCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $ContactsTableTable extends ContactsTable
    with TableInfo<$ContactsTableTable, ContactsTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactsTableTable(this._db, [this._alias]);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  late final GeneratedColumn<String?> avatar = GeneratedColumn<String?>(
      'avatar', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [createdAt, name, avatar, id];
  @override
  String get aliasedName => _alias ?? 'contacts_table';
  @override
  String get actualTableName => 'contacts_table';
  @override
  VerificationContext validateIntegrity(Insertable<ContactsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ContactsTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTableTable createAlias(String alias) {
    return $ContactsTableTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ContactsTableTable contactsTable = $ContactsTableTable(this);
  late final ContactDao contactDao = ContactDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [contactsTable];
}
