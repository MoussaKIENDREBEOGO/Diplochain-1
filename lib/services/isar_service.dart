import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/diploma.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      String? path;
      if (!kIsWeb) {
        final dir = await getApplicationDocumentsDirectory();
        path = dir.path;
      }
      return await Isar.open(
        [DiplomaSchema],
        name: 'diplochain_db',
        directory: path ?? '',
        inspector: false,
      );
    }
    return Future.value(Isar.getInstance('diplochain_db'));
  }

  // Diploma Operations
  Future<void> saveDiploma(Diploma diploma) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.diplomas.put(diploma);
    });
  }

  Future<List<Diploma>> getAllDiplomas() async {
    final isar = await db;
    return await isar.diplomas.where().findAll();
  }

  Future<Diploma?> getDiplomaByUid(String uid) async {
    final isar = await db;
    return await isar.diplomas.filter().uidEqualTo(uid).findFirst();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
