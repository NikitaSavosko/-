import 'package:hive_flutter/hive_flutter.dart';
import '../Models/Transaction_Model.dart';

class ToDoDataBase {

  List<Transaction> transactions = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    transactions = [
      Transaction(amount: 1432.45, type: false, name: 'Работа', description: '', time: DateTime(2023, 12, 31)),
      Transaction(amount: 346.14, type: true, name: 'Дом', description: '', time: DateTime(2023, 8, 23))
    ];
  }

  void loadData() {
    transactions = _myBox.get('TransactionList').cast<Transaction>();
  }

  void updateDataBase() {
    _myBox.put('TransactionList', transactions);
  }
}