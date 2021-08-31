import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '_name TEXT, '
      'numeroConta INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'nome';
  static const String _numeroConta = 'numeroConta';

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);

    if (contact.id == 0) {
      return db.insert(_tableName, contactMap);
    }
    return db.update(
      _tableName,
      contactMap,
      where: '$_id = ?',
      whereArgs: [contact.id],
    );
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.nome;
    contactMap[_numeroConta] = contact.numeroConta;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> map in result) {
      final Contact contact = Contact(
        map[_id],
        map[_name],
        map[_numeroConta],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
