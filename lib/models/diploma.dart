import 'package:isar/isar.dart';

part 'diploma.g.dart';

@collection
class Diploma {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(unique: true, replace: true)
  late String uid;

  late String studentName;
  late String degreeTitle;
  late String institutionName;
  late DateTime dateIssued;
  
  @Index()
  late String status; // 'VERIFIED', 'PENDING', 'INVALID'

  late String qrData;
}
