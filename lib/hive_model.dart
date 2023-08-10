import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 1)
class HiveModel {
  HiveModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String category;

  @HiveField(3)
  double amount;

  @HiveField(4)
  DateTime date;
}
