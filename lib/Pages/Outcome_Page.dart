import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Data/Data_Base.dart';
import '../Models/Transaction_Model.dart';

class OutcomePage extends StatefulWidget {
  const OutcomePage({super.key});

  @override
  State<OutcomePage> createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  late List<Transaction> filteredTransactions;
  var reversedTransaction;


  @override
  void initState() {

    if (_myBox.get('TransactionList') == null) {
      db.createInitialData();
    }

    else {
      db.loadData();
    }

    filteredTransactions = db.transactions.where((transaction) => transaction.type == true).toList();
    reversedTransaction = filteredTransactions.reversed.toList();

    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        
        title: Text(
          'Расходы',

          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        leading: IconButton(
          onPressed:() {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: reversedTransaction.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.ideographic,

                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,

                        children: [

                          Text(
                            reversedTransaction[index].name,
                          
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 20,
                            ),
                          ),
                          

                          Container(
                            width: 10,
                          ),

                          Text(
                            reversedTransaction[index].time.toIso8601String().substring(0, 10),

                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        reversedTransaction[index].description,
                      
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    '${reversedTransaction[index].amount} Br',

                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20,
                    ),
                  ),
                ]
              ),

              Container(
                height: 1,
                color: Colors.grey[500],
              ),
            ],
          );
        },
      ),
    );
  }
}