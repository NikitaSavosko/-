import 'package:hive_flutter/hive_flutter.dart';

part 'Transaction_Model.g.dart';

@HiveType(typeId: 1)

class Transaction {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  final bool type;
  
  Transaction({required this.amount, required this.type, required this.name, required this.description, required this.time});
}